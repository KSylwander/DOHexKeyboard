//
//  PaymentScenario.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-10-22.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

struct PaymentScenario {
  let podz: Podz

  let startingStateFactory: StartingStateFactory
  let waitForPodStateFactory: WaitForPodStateFactory
  let waitForBlipStateFactory: WaitForBlipStateFactory
  let setupTransferIdStateFactory: SetupTransferIdStateFactory
  let establishCloudSessionStateFactory: EstablishCloudSessionStateFactory
  let transferSessionTokenStateFactory: TransferSessionTokenStateFactory
  let waitForCloudSessionDoneStateFactory: WaitForCloudSessionDoneStateFactory
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
      return startingStateFactory.makeState(delegate: delegate, podz: podz)
    case .starting:
      return waitForPodStateFactory.makeState(delegate: delegate)
    case .waitForPod:
      return waitForBlipStateFactory.makeState(delegate: delegate)
    case let .waitForBlip(pid, podSession):
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
      return waitForBlipStateFactory.makeState(delegate: delegate)
    case .stopping:
      return nil
    default:
      fatalError("Unsupported previous state: \(previousState)")
    }
  }
}
