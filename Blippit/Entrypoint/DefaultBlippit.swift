//
//  DefaultBlippit.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

final class DefaultBlippit {
  private var isActive = false {
    didSet {
      if isActive {
        delegate?.blippitDidStart(self)
      } else {
        delegate?.blippitDidStop(self)
      }
    }
  }

  private weak var delegate: BlippitDelegate?

  private let podz: Podz

  private let startingStateFactory: StartingStateFactory
  private let startedStateFactory: StartedStateFactory
  private let setupTransferIdStateFactory: SetupTransferIdStateFactory
  private let establishCloudSessionStateFactory: EstablishCloudSessionStateFactory
  private let uploadCommandDataStateFactory: UploadCommandDataStateFactory
  private let transferDataTokenStateFactory: TransferDataTokenStateFactory
  private let waitForCloudSessionDoneStateFactory: WaitForCloudSessionDoneStateFactory

  private var userId: String!
  private static let commandData = CommandData(data: "Some interesting data") // TODO: Replace me with actual data

  private var currentState: State?

  init(delegate: BlippitDelegate,
       podz: Podz,
       startingStateFactory: StartingStateFactory,
       startedStateFactory: StartedStateFactory,
       setupTransferIdStateFactory: SetupTransferIdStateFactory,
       establishCloudSessionStateFactory: EstablishCloudSessionStateFactory,
       uploadCommandDataStateFactory: UploadCommandDataStateFactory,
       transferDataTokenStateFactory: TransferDataTokenStateFactory,
       waitForCloudSessionDoneStateFactory: WaitForCloudSessionDoneStateFactory) {

    self.delegate = delegate

    self.podz = podz

    self.startingStateFactory = startingStateFactory
    self.startedStateFactory = startedStateFactory
    self.setupTransferIdStateFactory = setupTransferIdStateFactory
    self.establishCloudSessionStateFactory = establishCloudSessionStateFactory
    self.uploadCommandDataStateFactory = uploadCommandDataStateFactory
    self.transferDataTokenStateFactory = transferDataTokenStateFactory
    self.waitForCloudSessionDoneStateFactory = waitForCloudSessionDoneStateFactory

    podz.onStatusChanged = { [weak self] status in
      self?.handlePodzStatus(status)
    }

    podz.onPodFound = { [weak self] pod in
      self?.handleNewPod(pod)
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
    pod.onStateChanged = { [weak self] pod, state in
      self?.handleState(state, for: pod)
    }
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

  private func setState(to rawState: RawState) {
    /* Create the actual state from the raw state metadata */
    let state: State? = {
      switch rawState {
      case .initial:
        isActive = false
        return nil
      case .starting:
        delegate?.blippitWillStart(self)
        return startingStateFactory.makeState(delegate: self, podz: podz)
      case .started:
        isActive = true
        return startedStateFactory.makeState(delegate: self)
      case let .setupTransferId(pid, podSession):
        return setupTransferIdStateFactory.makeState(delegate: self, pid: pid, session: podSession)
      case let .establishCloudSession(pid, podSession):
        return establishCloudSessionStateFactory.makeState(
          delegate: self,
          pid: pid,
          userId: userId,
          podSession: podSession
        )
      case let .uploadCommandData(cloudSessionId, podSession):
        return uploadCommandDataStateFactory.makeState(
          delegate: self,
          cloudSessionId: cloudSessionId,
          data: DefaultBlippit.commandData,
          podSession: podSession
        )
      case let .transferDataToken(cloudSessionId, podSession, dataToken):
        return transferDataTokenStateFactory.makeState(
          delegate: self,
          cloudSessionId: cloudSessionId,
          session: podSession,
          dataToken: dataToken
        )
      case let .waitForCloudSessionDone(cloudSessionId):
        return waitForCloudSessionDoneStateFactory.makeState(
          delegate: self,
          cloudSessionId: cloudSessionId
        )
      case .blippitSessionCompleted:
        return StartedState(delegate: self)
      }
    }()

    Log.debug(.public("Transitioning to \(rawState.logDescription) state (\(state?.name ?? "nil"))..."))

    /* Assigning the current state here makes sure that any state changes during the invocation of the `start()` method
     * below are only applied afterwards
     */
    currentState = state

    /* Start the state, if applicable */
    if let state = state as? Startable {
      state.start()
    }
  }
}

extension DefaultBlippit: Blippit {
  func start(userId: String) {
    guard currentState == nil else {
      return
    }
    self.userId = userId
    setState(to: .starting)
  }

  func stop() {
    guard currentState != nil else {
      return
    }

    cancelCurrentState()
    podz.stop()

    setState(to: .initial)
  }

  func reset() {
    // TODO: Implement me
  }
}

extension DefaultBlippit: StateDelegate {
  func state(_ state: State, moveTo nextState: RawState) {
    setState(to: nextState)
  }

  func state(_ state: State, didFailWithError error: Error) {
    Log.error(.public("Error: \(error.name)"))
    delegate?.blippit(self, didFailWithError: error)
  }
}
