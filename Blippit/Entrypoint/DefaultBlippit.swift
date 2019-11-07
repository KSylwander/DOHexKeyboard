//
//  DefaultBlippit.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import PodzKit

final class DefaultBlippit {
  private weak var delegate: BlippitDelegate?

  private let podz: Podz

  private let scenarioFactory: ScenarioFactory
  private lazy var scenario = scenarioFactory.makeScenario(delegate: self)

  private let errorHandler: ErrorHandling

  private var currentState: State?
  private var isStateTransitioningDisabled = false

  private var managedPods = [UInt32: Pod]()

  init(delegate: BlippitDelegate, podz: Podz, scenarioFactory: ScenarioFactory, errorHandler: ErrorHandling) {
    self.delegate = delegate

    self.podz = podz
    self.scenarioFactory = scenarioFactory

    self.errorHandler = errorHandler

    podz.onStatusChanged = { [weak self] status in
      self?.handlePodzStatus(status)
    }

    podz.onPodFound = { [weak self] pod in
      self?.handleNewPod(pod)
    }

    podz.onPodLost = { [weak self] pod in
      self?.handleLostPod(pod)
    }
  }

  private func cancelCurrentState() {
    /* Abort the current state, if applicable */
    guard let currentState = currentState as? Cancellable else {
      return
    }
    currentState.cancel()
  }

  private func handlePodzStatus(_ status: PodzStatus) {
    /* Propagate Podz status changes to the current state, if applicable */
    guard let currentState = currentState as? PodzStatusObserving else {
      return
    }
    currentState.handleStatus(status, for: podz)
  }

  private func handleNewPod(_ pod: Pod) {
    /* Propagate new pod event to the current state, if applicable */
    if let currentState = currentState as? NewPodObserving {
      currentState.handleNewPod(pod)
    }
    managedPods[pod.pid] = pod

    pod.onStateChanged = { [weak self] pod, state in
      self?.handleState(state, for: pod)
    }
  }

  private func handleLostPod(_ pod: Pod) {
    /* Propagate lost pod event to the current state, if applicable */
    if let currentState = currentState as? LostPodObserving {
      currentState.handleLostPod(pod)
    }
    managedPods.removeValue(forKey: pod.pid)
  }

  private func handleState(_ state: PodState, for pod: Pod) {
    if case let .blip(session) = state {
      session.onSessionStateChanged = { [weak self] session, state in
        self?.handleState(state, for: session)
      }
    }

    /* Propagate pod state changes to the current state, if applicable */
    if let currentState = currentState as? PodStateObserving {
      currentState.handleState(state, for: pod)
    }
  }

  private func handleState(_ state: PodSessionState, for session: PodSession) {
    /* Propagate session state changes to the current state, if applicable */
    guard let currentState = currentState as? PodSessionStateObserving else {
      return
    }
    currentState.handleState(state, for: session)
  }

  private func moveState(to state: State?) {
    guard !isStateTransitioningDisabled else {
      return
    }

    Log.debug(.public("Transitioning to \(state.logDescription)..."))

    /* Assigning the current state here makes sure that any state changes during the invocation of the `start()` method
     * below are only applied afterwards
     */
    currentState = state

    /* Start the state, if applicable */
    if let state = state as? Startable {
      state.start()
    }

    /* Allow interested states (e.g., wait-for-pod, wait-for-blip) to receive all managed pods */
    if let state = state as? NewPodObserving {
      managedPods.values.forEach(state.handleNewPod(_:))
    }
  }
}

extension DefaultBlippit: Blippit {
  func start() {
    guard currentState == nil else {
      return
    }
    scenario.start()
  }

  func stop() {
    guard currentState != nil else {
      return
    }

    isStateTransitioningDisabled = true
    cancelCurrentState()
    isStateTransitioningDisabled = false

    scenario.stop()
    podz.stop()
  }

  func cancelOngoingSession() {
    /* Abort the current stage, if applicable */
    guard let currentState = currentState as? BlippitSessionState else {
      return
    }
    currentState.cancel()
  }
}

extension DefaultBlippit: ScenarioDelegate {
  func scenario(_ scenario: Scenario, moveTo state: State?) {
    moveState(to: state)
  }

  func scenario(_ scenario: Scenario, didFailWithError error: Error) {
    Log.error(.public("Error: \(error.logDescription)"))

    switch error {
    case is ConfigurationError:
      stop()
    default:
      /* Do nothing */
      break
    }
    delegate?.blippit(self, didFailWithError: errorHandler.handleError(error))
  }

  func scenario(_ scenario: Scenario, didChangeBlippitState blippitState: BlippitState) {
    delegate?.blippit(self, didChangeState: blippitState)
  }
}
