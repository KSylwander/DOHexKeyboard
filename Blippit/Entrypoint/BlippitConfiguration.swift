//
//  BlippitConfiguration.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

public struct BlippitConfiguration {
  public let mode: BlippitMode

  public init(mode: BlippitMode) {
    self.mode = mode
  }
}
