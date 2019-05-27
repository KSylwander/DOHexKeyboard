//
//  DefaultBlippitFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

struct DefaultBlippitFactory {
  let establishCloudSessionUseCaseFactory: EstablishCloudSessionUseCaseFactory
  let uploadCommandDataUseCase: UploadCommandDataUseCase
  let retryHandlerFactory: RetryHandlerFactory
}

extension DefaultBlippitFactory: BlippitFactory {
  func makeBlippit(delegate: BlippitDelegate, configuration: BlippitConfiguration) throws -> Blippit {
    return DefaultBlippit(
      delegate: delegate,
      podz: try PodzSetup.setup(appId: configuration.podzAppId, apiKey: configuration.podzApiKey),
      establishCloudSessionUseCase: establishCloudSessionUseCaseFactory.makeUseCase(appId: configuration.blippitAppId),
      uploadCommandDataUseCase: uploadCommandDataUseCase,
      retryHandlerFactory: retryHandlerFactory
    )
  }
}
