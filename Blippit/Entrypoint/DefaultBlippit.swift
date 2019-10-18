//
//  DefaultBlippit.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

final class DefaultBlippit {
  private weak var delegate: BlippitDelegate?

  private let podz: Podz

  private let startingStateFactory: StartingStateFactory
  private let waitForPodStateFactory: WaitForPodStateFactory
  private let waitForBlipStateFactory: WaitForBlipStateFactory
  private let setupTransferIdStateFactory: SetupTransferIdStateFactory
  private let establishCloudSessionStateFactory: EstablishCloudSessionStateFactory
  private let transferSessionTokenStateFactory: TransferSessionTokenStateFactory
  private let waitForCloudSessionDoneStateFactory: WaitForCloudSessionDoneStateFactory

  private var currentState: State?
  private var isStateTransitioningDisabled = false

  private var blippedPod: Pod?

  init(delegate: BlippitDelegate,
       podz: Podz,
       startingStateFactory: StartingStateFactory,
       waitForPodStateFactory: WaitForPodStateFactory,
       waitForBlipStateFactory: WaitForBlipStateFactory,
       setupTransferIdStateFactory: SetupTransferIdStateFactory,
       establishCloudSessionStateFactory: EstablishCloudSessionStateFactory,
       transferSessionTokenStateFactory: TransferSessionTokenStateFactory,
       waitForCloudSessionDoneStateFactory: WaitForCloudSessionDoneStateFactory) {

    self.delegate = delegate

    self.podz = podz

    self.startingStateFactory = startingStateFactory
    self.waitForPodStateFactory = waitForPodStateFactory
    self.waitForBlipStateFactory = waitForBlipStateFactory
    self.setupTransferIdStateFactory = setupTransferIdStateFactory
    self.establishCloudSessionStateFactory = establishCloudSessionStateFactory
    self.transferSessionTokenStateFactory = transferSessionTokenStateFactory
    self.waitForCloudSessionDoneStateFactory = waitForCloudSessionDoneStateFactory

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

    pod.onStateChanged = { [weak self] pod, state in
      self?.handleState(state, for: pod)
    }
  }

  private func handleLostPod(_ pod: Pod) {
    guard pod.pid == blippedPod?.pid else {
      return
    }
    blippedPod = nil
  }

  private func handleState(_ state: PodState, for pod: Pod) {
    if case let .blip(session) = state {
      session.onSessionStateChanged = { [weak self] session, state in
        self?.handleState(state, for: session)
      }
      blippedPod = pod
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

  private func setState(to rawState: RawState) {
    guard !isStateTransitioningDisabled else {
      return
    }

    /* Create the actual state from the raw state metadata */
    let state: State? = {
      switch rawState {
      case .initial:
        return nil
      case .starting:
        delegate?.blippit(self, didChangeState: .started)
        return startingStateFactory.makeState(delegate: self, podz: podz)
      case .waitForPod:
        delegate?.blippit(self, didChangeState: .lookingForAppTerminals)
        return waitForPodStateFactory.makeState(delegate: self)
      case .waitForBlip:
        delegate?.blippit(self, didChangeState: .appTerminalFound)
        return waitForBlipStateFactory.makeState(delegate: self)
      case let .setupTransferId(pid, podSession):
        delegate?.blippit(self, didChangeState: .sessionInitiated)
        return setupTransferIdStateFactory.makeState(delegate: self, pid: pid, session: podSession)
      case let .establishCloudSession(pid, podSession):
        return establishCloudSessionStateFactory.makeState(
          delegate: self,
          pid: pid,
          podSession: podSession
        )
      case let .transferSessionToken(cloudSessionId, podSession, sessionToken):
        return transferSessionTokenStateFactory.makeState(
          delegate: self,
          cloudSessionId: cloudSessionId,
          session: podSession,
          sessionToken: sessionToken
        )
      case let .waitForCloudSessionDone(cloudSessionId, podSession):
        return waitForCloudSessionDoneStateFactory.makeState(
          delegate: self,
          cloudSessionId: cloudSessionId,
          podSession: podSession
        )
      case .blippitSessionCompleted:
        delegate?.blippit(self, didChangeState: .sessionDone)
        delegate?.blippit(self, didChangeState: .appTerminalFound)
        return waitForBlipStateFactory.makeState(delegate: self)
      }
    }()

    Log.debug(.public("Transitioning to \(rawState.logDescription) state (\(state.logDescription))..."))

    /* Assigning the current state here makes sure that any state changes during the invocation of the `start()` method
     * below are only applied afterwards
     */
    currentState = state

    /* Start the state, if applicable */
    if let state = state as? Startable {
      state.start()
    }

    /* Allow interested states (e.g., wait-for-pod) to receive the blipped pod if the latter is still within range */
    blippedPod.map(handleNewPod(_:))
  }
}

extension DefaultBlippit: Blippit {
  func start() {
    guard currentState == nil else {
      return
    }
    setState(to: .starting)
  }

  func stop() {
    guard currentState != nil else {
      return
    }

    isStateTransitioningDisabled = true
    cancelCurrentState()
    podz.stop()
    isStateTransitioningDisabled = false

    setState(to: .initial)

    delegate?.blippit(self, didChangeState: .stopped)
  }

  func cancelOngoingSession() {
    /* Abort the current stage, if applicable */
    guard let currentState = currentState as? BlippitSessionState else {
      return
    }
    currentState.cancel()
  }
}

extension DefaultBlippit: StateDelegate {
  func state(_ state: State, moveTo nextState: RawState) {
    setState(to: nextState)
  }

  func state(_ state: State, didFailWithError error: Error) {
    Log.error(.public("Error: \(error.logDescription)"))
    delegate?.blippit(self, didFailWithError: error)
  }
}
