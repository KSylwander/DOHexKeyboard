//
//  TransferPayloadOnBlipScenario.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

final class TransferPayloadOnBlipScenario: BaseScenario {
  private let transferPayloadOnBlipStateFactory: TransferPayloadOnBlipStateFactory

  init(delegate: ScenarioDelegate,
       podz: Podz,
       startingStateFactory: StartingStateFactory,
       waitForPodStateFactory: WaitForPodStateFactory,
       waitForBlipStateFactory: WaitForBlipStateFactory,
       setupTransferPayloadStateFactory: SetupTransferPayloadStateFactory,
       transferPayloadOnBlipStateFactory: TransferPayloadOnBlipStateFactory) {

    self.transferPayloadOnBlipStateFactory = transferPayloadOnBlipStateFactory
    super.init(
      delegate: delegate,
      podz: podz,
      startingStateFactory: startingStateFactory,
      waitForPodStateFactory: waitForPodStateFactory,
      waitForBlipStateFactory: waitForBlipStateFactory,
      setupTransferPayloadStateFactory: setupTransferPayloadStateFactory
    )
  }

  override func makeNextState(from stateOutput: StateOutput) -> State {
    switch stateOutput {
    case let .setupTransferPayload(_, podSession):
      return transferPayloadOnBlipStateFactory.makeState(delegate: self, session: podSession)
    case .transferPayloadOnBlip:
      delegate?.scenario(self, didChangeBlippitState: .transferDone)
      delegate?.scenario(self, didChangeBlippitState: .appTerminalFound)
      return waitForBlipStateFactory.makeState(delegate: self)
    default:
      return super.makeNextState(from: stateOutput)
    }
  }
}
