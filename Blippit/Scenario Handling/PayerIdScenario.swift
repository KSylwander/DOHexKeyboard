//
//  PayerIdScenario.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-10-22.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

struct PayerIdScenario {
  let podz: Podz

  let startingStateFactory: StartingStateFactory
  let waitForPodStateFactory: WaitForPodStateFactory
  let waitForBlipStateFactory: WaitForBlipStateFactory
  let setupTransferIdStateFactory: SetupTransferIdStateFactory
  let transferPayerIdStateFactory: TransferPayerIdStateFactory
}

extension PayerIdScenario: Scenario {
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
    case let .setupTransferId(_, podSession):
      return transferPayerIdStateFactory.makeState(delegate: delegate, session: podSession)
    case .stopping:
      return nil
    default:
      fatalError("Unsupported previous state: \(previousState)")
    }
  }
}
