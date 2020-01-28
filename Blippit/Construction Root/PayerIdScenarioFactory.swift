//
//  PayerIdScenarioFactory.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

struct PayerIdScenarioFactory {
  let podz: Podz

  let startingStateFactory: StartingStateFactory
  let waitForPodStateFactory: WaitForPodStateFactory
  let waitForBlipStateFactory: WaitForBlipStateFactory
  let setupTransferIdStateFactory: SetupTransferIdStateFactory
  let transferPayerIdStateFactory: TransferPayerIdStateFactory
}

extension PayerIdScenarioFactory: ScenarioFactory {
  func makeScenario(delegate: ScenarioDelegate) -> Scenario {
    return PayerIdScenario(
      delegate: delegate,
      podz: podz,
      startingStateFactory: startingStateFactory,
      waitForPodStateFactory: waitForPodStateFactory,
      waitForBlipStateFactory: waitForBlipStateFactory,
      setupTransferIdStateFactory: setupTransferIdStateFactory,
      transferPayerIdStateFactory: transferPayerIdStateFactory
    )
  }
}
