//
//  GetCloudSessionStatusUseCaseFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-23.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol GetCloudSessionStatusUseCaseFactory {
  func makeUseCase(apiKey: UUID) -> GetCloudSessionStatusUseCase
}
