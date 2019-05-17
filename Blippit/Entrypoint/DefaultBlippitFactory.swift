//
//  DefaultBlippitFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

struct DefaultBlippitFactory {
  let startingStateFactory: StartingStateFactory
  let startedStateFactory: StartedStateFactory
  let setupTransferIdStateFactory: SetupTransferIdStateFactory
  let uploadCommandDataStateFactory: UploadCommandDataStateFactory
  let transferDataTokenStateFactory: TransferDataTokenStateFactory
  let establishCloudSessionUseCaseFactory: EstablishCloudSessionUseCaseFactory
}

extension DefaultBlippitFactory: BlippitFactory {
  func makeBlippit(delegate: BlippitDelegate, configuration: BlippitConfiguration) throws -> Blippit {
    return DefaultBlippit(
      delegate: delegate,
      podz: try PodzSetup.setup(appId: configuration.podzAppId, apiKey: configuration.podzApiKey),
      startingStateFactory: startingStateFactory,
      startedStateFactory: startedStateFactory,
      setupTransferIdStateFactory: setupTransferIdStateFactory,
      uploadCommandDataStateFactory: uploadCommandDataStateFactory,
      transferDataTokenStateFactory: transferDataTokenStateFactory,
      establishCloudSessionUseCase: establishCloudSessionUseCaseFactory.makeUseCase(appId: configuration.blippitAppId)
    )
  }
}
