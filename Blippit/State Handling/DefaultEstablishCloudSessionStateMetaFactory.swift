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
}

extension DefaultEstablishCloudSessionStateMetaFactory: EstablishCloudSessionStateMetaFactory {
  func makeFactory(appId: UUID) -> EstablishCloudSessionStateFactory {
    return DefaultEstablishCloudSessionStateFactory(
      establishCloudSessionUseCase: establishCloudSessionUseCaseFactory.makeUseCase(appId: appId)
    )
  }
}
