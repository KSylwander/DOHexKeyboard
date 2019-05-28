//
//  EstablishCloudSessionStateMetaFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-19.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol EstablishCloudSessionStateMetaFactory {
  func makeFactory(apiKey: UUID, appId: UUID) -> EstablishCloudSessionStateFactory
}
