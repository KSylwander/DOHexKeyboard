//
//  PayerIdScenario.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-10-22.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import PodzKit

final class PayerIdScenario: BaseScenario {
  private let transferPayerIdStateFactory: TransferPayerIdStateFactory

  init(delegate: ScenarioDelegate,
       podz: Podz,
       startingStateFactory: StartingStateFactory,
       waitForPodStateFactory: WaitForPodStateFactory,
       waitForBlipStateFactory: WaitForBlipStateFactory,
       setupTransferIdStateFactory: SetupTransferIdStateFactory,
       transferPayerIdStateFactory: TransferPayerIdStateFactory) {

    self.transferPayerIdStateFactory = transferPayerIdStateFactory
    super.init(
      delegate: delegate,
      podz: podz,
      startingStateFactory: startingStateFactory,
      waitForPodStateFactory: waitForPodStateFactory,
      waitForBlipStateFactory: waitForBlipStateFactory,
      setupTransferIdStateFactory: setupTransferIdStateFactory
    )
  }

  override func makeNextState(from stateOutput: StateOutput) -> State {
    switch stateOutput {
    case let .setupTransferId(_, podSession):
      return transferPayerIdStateFactory.makeState(delegate: self, session: podSession)
    case .transferPayerId:
      delegate?.scenario(self, didChangeBlippitState: .sessionDone)
      delegate?.scenario(self, didChangeBlippitState: .appTerminalFound)
      return waitForBlipStateFactory.makeState(delegate: self)
    default:
      return super.makeNextState(from: stateOutput)
    }
  }
}
