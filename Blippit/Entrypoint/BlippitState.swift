//
//  BlippitState.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

/**
 * States of the `Blippit` instance.
 *
 * ![Blippit state transitions](../img/blippit_states.png)
 *
 * Receive state changes by implementing the `BlippitDelegate.blippit(_:didChangeState:)` method, and passing the
 * delegate implementation to the `BlippitSetup.setup(delegate:onBlipPayload:)` method.
 */
public enum BlippitState {
  /**
   * `Blippit` has been started. This happens immediately when calling `Blippit.start()`.
   *
   * Any errors that occur in this stage will be passed to the `BlippitDelegate.blippit(_:didFailWithError:)` method.
   */
  case started

  /**
   * `Blippit` is waiting for the first app terminal to be found.
   */
  case lookingForAppTerminals

  /**
   * `Blippit` found app terminals in the vicinity, and is waiting for the user to blip on any one of them.
   */
  case appTerminalFound

  /**
   * The user has initiated a transfer by blipping on one of the available app terminals.
   */
  case transferInitiated

  /**
   * The transfer is successfully completed. The transition to this state only happens momentarily before
   * transitioning back to `BlippitState.lookingForAppTerminals`.
   */
  case transferDone

  /**
   * `Blippit` has been stopped. It is now ready to be deallocated or started again.
   */
  case stopped
}
