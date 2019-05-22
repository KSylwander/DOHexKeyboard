//
//  DefaultEstablishCloudSessionStateMetaFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-19.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct DefaultEstablishCloudSessionStateMetaFactory {
  let establishCloudSessionUseCaseFactory: EstablishCloudSessionUseCaseFactory
  let retryHandlerFactory: AsyncRetryHandlerFactory
}

extension DefaultEstablishCloudSessionStateMetaFactory: EstablishCloudSessionStateMetaFactory {
  func makeFactory(apiKey: UUID, appId: UUID) -> EstablishCloudSessionStateFactory {
    return DefaultEstablishCloudSessionStateFactory(
      establishCloudSessionUseCase: establishCloudSessionUseCaseFactory.makeUseCase(apiKey: apiKey, appId: appId),
      retryHandlerFactory: retryHandlerFactory
    )
  }
}
