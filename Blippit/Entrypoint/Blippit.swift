//
//  Blippit.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

/**
 * The main interface of the BlippitKit.
 *
 * Create an instance of this through the `BlippitSetup.setup(delegate:onBlipPayload:)` method.
 */
public protocol Blippit {
  /**
   * Call when the app is ready to perform transfers via the app terminal.
   */
  func start()

  /**
   * Call when the app is no longer interested in performing app terminal transfers. This makes sure that any ongoing
   * state is cancelled and cleaned-up.
   */
  func stop()
}
