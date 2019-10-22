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

  public let mode: BlippitMode

  public init(podzApiKey: UUID, podzAppId: UUID, mode: BlippitMode) {
    self.podzApiKey = podzApiKey
    self.podzAppId = podzAppId

    self.mode = mode
  }
}
