//
//  PaymentScenarioFactory.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

struct PaymentScenarioFactory {
  let podz: Podz

  let startingStateFactory: StartingStateFactory
  let waitForPodStateFactory: WaitForPodStateFactory
  let waitForBlipStateFactory: WaitForBlipStateFactory
  let setupTransferIdStateFactory: SetupTransferIdStateFactory
  let establishCloudSessionStateFactory: EstablishCloudSessionStateFactory
  let transferSessionTokenStateFactory: TransferSessionTokenStateFactory
  let waitForCloudSessionDoneStateFactory: WaitForCloudSessionDoneStateFactory
}

extension PaymentScenarioFactory: ScenarioFactory {
  func makeScenario(delegate: ScenarioDelegate) -> Scenario {
    return PaymentScenario(
      delegate: delegate,
      podz: podz,
      startingStateFactory: startingStateFactory,
      waitForPodStateFactory: waitForPodStateFactory,
      waitForBlipStateFactory: waitForBlipStateFactory,
      setupTransferIdStateFactory: setupTransferIdStateFactory,
      establishCloudSessionStateFactory: establishCloudSessionStateFactory,
      transferSessionTokenStateFactory: transferSessionTokenStateFactory,
      waitForCloudSessionDoneStateFactory: waitForCloudSessionDoneStateFactory
    )
  }
}
