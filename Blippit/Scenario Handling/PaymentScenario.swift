//
//  PaymentScenario.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-10-22.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import PodzKit

final class PaymentScenario {
  private(set) weak var delegate: ScenarioDelegate?

  private let podz: Podz

  private let startingStateFactory: StartingStateFactory
  private let waitForPodStateFactory: WaitForPodStateFactory
  private let waitForBlipStateFactory: WaitForBlipStateFactory
  private let setupTransferIdStateFactory: SetupTransferIdStateFactory
  private let establishCloudSessionStateFactory: EstablishCloudSessionStateFactory
  private let transferSessionTokenStateFactory: TransferSessionTokenStateFactory
  private let waitForCloudSessionDoneStateFactory: WaitForCloudSessionDoneStateFactory

  init(delegate: ScenarioDelegate,
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
  }
}

extension PaymentScenario: Scenario {}

extension PaymentScenario: TransitionStateFactory {
  func makeStartState() -> State {
    delegate?.scenario(self, didChangeBlippitState: .started)
    return startingStateFactory.makeState(delegate: self, podz: podz)
  }

  func makeStopState() -> State? {
    delegate?.scenario(self, didChangeBlippitState: .stopped)
    return nil
  }

  func makeState(for transition: StateTransition) -> State {
    switch transition {
    case let .previous(from: state):
      fatalError("Unsupported previous state: \(state.logDescription)")
    case let .next(from: stateOutput):
      switch stateOutput {
      case .starting:
        delegate?.scenario(self, didChangeBlippitState: .lookingForAppTerminals)
        return waitForPodStateFactory.makeState(delegate: self)
      case .waitForPod:
        delegate?.scenario(self, didChangeBlippitState: .appTerminalFound)
        return waitForBlipStateFactory.makeState(delegate: self)
      case let .waitForBlip(pid, podSession):
        delegate?.scenario(self, didChangeBlippitState: .sessionInitiated)
        return setupTransferIdStateFactory.makeState(delegate: self, pid: pid, session: podSession)
      case let .setupTransferId(pid, podSession):
        return establishCloudSessionStateFactory.makeState(
          delegate: self,
          pid: pid,
          podSession: podSession
        )
      case let .establishCloudSession(cloudSessionId, podSession, sessionToken):
        return transferSessionTokenStateFactory.makeState(
          delegate: self,
          cloudSessionId: cloudSessionId,
          session: podSession,
          sessionToken: sessionToken
        )
      case let .transferSessionToken(cloudSessionId, podSession):
        return waitForCloudSessionDoneStateFactory.makeState(
          delegate: self,
          cloudSessionId: cloudSessionId,
          podSession: podSession
        )
      case .waitForCloudSessionDone:
        delegate?.scenario(self, didChangeBlippitState: .sessionDone)
        delegate?.scenario(self, didChangeBlippitState: .appTerminalFound)
        return waitForBlipStateFactory.makeState(delegate: self)
      default:
        fatalError("Unsupported state output: \(stateOutput)")
      }
    case .cancelled:
      /* Move back to the starting state after a cancellation. This allows us to make sure that the Podz is still in
       * the correct state after the previous operations.
       */
      return startingStateFactory.makeState(delegate: self, podz: podz)
    }
  }
}

extension PaymentScenario: StateDelegate {}
