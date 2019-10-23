//
//  PaymentScenario.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-10-22.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

final class PaymentScenario {
  private weak var delegate: ScenarioDelegate?

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

extension PaymentScenario: Scenario {
  func nextState(for previousState: PreviousState, delegate: StateDelegate) -> State? {
    switch previousState {
    case .cancelling:
      /* Move back to the starting state after a cancellation. This allows us to make sure that the Podz is still in
       * the correct state after the previous operations.
       */
      fallthrough
    case .initial:
      self.delegate?.scenario(self, didChangeBlippitState: .started)
      return startingStateFactory.makeState(delegate: delegate, podz: podz)
    case .starting:
      self.delegate?.scenario(self, didChangeBlippitState: .lookingForAppTerminals)
      return waitForPodStateFactory.makeState(delegate: delegate)
    case .waitForPod:
      self.delegate?.scenario(self, didChangeBlippitState: .appTerminalFound)
      return waitForBlipStateFactory.makeState(delegate: delegate)
    case let .waitForBlip(pid, podSession):
      self.delegate?.scenario(self, didChangeBlippitState: .sessionInitiated)
      return setupTransferIdStateFactory.makeState(delegate: delegate, pid: pid, session: podSession)
    case let .setupTransferId(pid, podSession):
      return establishCloudSessionStateFactory.makeState(
        delegate: delegate,
        pid: pid,
        podSession: podSession
      )
    case let .establishCloudSession(cloudSessionId, podSession, sessionToken):
      return transferSessionTokenStateFactory.makeState(
        delegate: delegate,
        cloudSessionId: cloudSessionId,
        session: podSession,
        sessionToken: sessionToken
      )
    case let .transferSessionToken(cloudSessionId, podSession):
      return waitForCloudSessionDoneStateFactory.makeState(
        delegate: delegate,
        cloudSessionId: cloudSessionId,
        podSession: podSession
      )
    case .waitForCloudSessionDone:
      self.delegate?.scenario(self, didChangeBlippitState: .sessionDone)
      self.delegate?.scenario(self, didChangeBlippitState: .appTerminalFound)
      return waitForBlipStateFactory.makeState(delegate: delegate)
    case .stopping:
      return nil
    default:
      fatalError("Unsupported previous state: \(previousState)")
    }
  }
}
