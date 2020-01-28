//
//  PaymentScenario.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

final class PaymentScenario: BaseScenario {
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

    self.establishCloudSessionStateFactory = establishCloudSessionStateFactory
    self.transferSessionTokenStateFactory = transferSessionTokenStateFactory
    self.waitForCloudSessionDoneStateFactory = waitForCloudSessionDoneStateFactory
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
    case let .setupTransferId(pid, podSession):
      return establishCloudSessionStateFactory.makeState(
        delegate: self,
        pid: pid,
        podSession: podSession
      )
    case let .establishCloudSession(cloudSessionId, podSession, sessionToken):
      return transferSessionTokenStateFactory.makeState(
        delegate: self,
        cloudSessionId: cloudSessionId,
        session: podSession,
        sessionToken: sessionToken
      )
    case let .transferSessionToken(cloudSessionId, podSession):
      return waitForCloudSessionDoneStateFactory.makeState(
        delegate: self,
        cloudSessionId: cloudSessionId,
        podSession: podSession
      )
    case .waitForCloudSessionDone:
      delegate?.scenario(self, didChangeBlippitState: .sessionDone)
      delegate?.scenario(self, didChangeBlippitState: .appTerminalFound)
      return waitForBlipStateFactory.makeState(delegate: self)
    default:
      return super.makeNextState(from: stateOutput)
    }
  }
}
