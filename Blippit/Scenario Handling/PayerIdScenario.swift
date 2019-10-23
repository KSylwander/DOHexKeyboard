//
//  PayerIdScenario.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-10-22.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

final class PayerIdScenario {
  private weak var delegate: ScenarioDelegate?

  private let podz: Podz

  private let startingStateFactory: StartingStateFactory
  private let waitForPodStateFactory: WaitForPodStateFactory
  private let waitForBlipStateFactory: WaitForBlipStateFactory
  private let setupTransferIdStateFactory: SetupTransferIdStateFactory
  private let transferPayerIdStateFactory: TransferPayerIdStateFactory

  init(delegate: ScenarioDelegate,
       podz: Podz,
       startingStateFactory: StartingStateFactory,
       waitForPodStateFactory: WaitForPodStateFactory,
       waitForBlipStateFactory: WaitForBlipStateFactory,
       setupTransferIdStateFactory: SetupTransferIdStateFactory,
       transferPayerIdStateFactory: TransferPayerIdStateFactory) {

    self.delegate = delegate
    self.podz = podz
    self.startingStateFactory = startingStateFactory
    self.waitForPodStateFactory = waitForPodStateFactory
    self.waitForBlipStateFactory = waitForBlipStateFactory
    self.setupTransferIdStateFactory = setupTransferIdStateFactory
    self.transferPayerIdStateFactory = transferPayerIdStateFactory
  }
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
    case let .setupTransferId(_, podSession):
      return transferPayerIdStateFactory.makeState(delegate: delegate, session: podSession)
    case .transferPayerId:
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
