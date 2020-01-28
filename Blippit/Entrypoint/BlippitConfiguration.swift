//
//  BlippitConfiguration.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
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
