//
//  Blippit.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

/**
 * The main interface of the Blippit SDK.
 *
 * Create an instance of this through the `BlippitSetup.setup(delegate:configuration:)` method.
 */
public protocol Blippit {
  /**
   * Call when the app is ready to perform payments via the app terminal.
   */
  func start()

  /**
   * Call when the app is no longer interested in performing app terminal payments. This makes sure that any ongoing
   * state is cancelled and cleaned-up.
   */
  func stop()
}
