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
   * Call when the app is ready to perform payments via the app terminal. How the actual transaction is performed, as
   * well as what transaction info it will use, depends on the mode set when this `Blippit` instance is built.
   */
  func start()

  /**
   * Call when the app is no longer interested in performing app terminal payments. This makes sure that any ongoing
   * state is cancelled and cleaned-up.
   */
  func stop()

  /**
   * Cancels an ongoing payment session and moves back to `BlippitState.lookingForAppTerminals`.
   */
  func cancelOngoingSession()
}
