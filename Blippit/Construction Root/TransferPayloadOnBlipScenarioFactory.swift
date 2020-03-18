//
//  TransferPayloadOnBlipScenarioFactory.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

struct TransferPayloadOnBlipScenarioFactory {
  let podz: Podz

  let startingStateFactory: StartingStateFactory
  let waitForPodStateFactory: WaitForPodStateFactory
  let waitForBlipStateFactory: WaitForBlipStateFactory
  let setupTransferPayloadStateFactory: SetupTransferPayloadStateFactory
  let transferPayloadOnBlipStateFactory: TransferPayloadOnBlipStateFactory
}

extension TransferPayloadOnBlipScenarioFactory: ScenarioFactory {
  func makeScenario(delegate: ScenarioDelegate) -> Scenario {
    return TransferPayloadOnBlipScenario(
      delegate: delegate,
      podz: podz,
      startingStateFactory: startingStateFactory,
      waitForPodStateFactory: waitForPodStateFactory,
      waitForBlipStateFactory: waitForBlipStateFactory,
      setupTransferPayloadStateFactory: setupTransferPayloadStateFactory,
      transferPayloadOnBlipStateFactory: transferPayloadOnBlipStateFactory
    )
  }
}
