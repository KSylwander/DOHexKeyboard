//
//  Blippit.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

/**
 * The main interface of the Blippit SDK.
 *
 * Create an instance of this through the `BlippitSetup.setup(delegate:configuration:)` method.
 */
public protocol Blippit {
  /**
   * Call when the app is interested in accepting payments via an app terminal.
   */
  func start()

  /**
   * Call when the app is no longer interested in accepting app terminal payments. This makes sure that any ongoing
   * state is cancelled and cleaned-up.
   */
  func stop()

  /**
   * Cancels an ongoing payment session and moves back to `BlippitState.lookingForAppTerminals`.
   */
  func cancelOngoingSession()
}
