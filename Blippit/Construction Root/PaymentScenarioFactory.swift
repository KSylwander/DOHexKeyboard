//
//  PaymentScenarioFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-10-23.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

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
