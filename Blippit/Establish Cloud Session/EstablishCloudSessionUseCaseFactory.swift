//
//  EstablishCloudSessionUseCaseFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol EstablishCloudSessionUseCaseFactory {
  func makeUseCase(apiKey: UUID, appId: UUID) -> EstablishCloudSessionUseCase
}
