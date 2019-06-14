//
//  BlippitConfiguration.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

public struct BlippitConfiguration {
  public let podzApiKey: UUID
  public let podzAppId: UUID

  public let blippitApiKey: UUID
  public let blippitAppId: UUID

  public let serviceInfo: ServiceInfo

  public init(podzApiKey: UUID, podzAppId: UUID, blippitApiKey: UUID, blippitAppId: UUID, serviceInfo: ServiceInfo) {
    self.podzApiKey = podzApiKey
    self.podzAppId = podzAppId

    self.blippitApiKey = blippitApiKey
    self.blippitAppId = blippitAppId

    self.serviceInfo = serviceInfo
  }
}
