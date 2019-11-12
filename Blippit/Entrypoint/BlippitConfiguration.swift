//
//  BlippitConfiguration.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

/**
 * Configuration of the Blippit SDK instance.
 *
 * See `BlippitMode` for details on how to change the behaviour of the Blippit SDK.
 */
public struct BlippitConfiguration {
  /**
   * Determines the behaviour of the Blippit SDK.
   */
  public let mode: BlippitMode

  /**
   * Creates a new instance.
   */
  public init(mode: BlippitMode) {
    self.mode = mode
  }
}
