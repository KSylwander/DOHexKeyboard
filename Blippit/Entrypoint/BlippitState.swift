//
//  BlippitState.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

/**
 * States of the Blippit SDK instance.
 *
 * ![Blippit state transitions](../img/blippit_states.png)
 *
 * Receive state changes by implementing the `BlippitDelegate.blippit(_:didChangeState:)` method, and passing the
 * delegate implementation to the `BlippitSetup.setup(delegate:configuration:)` method.
 */
public enum BlippitState {
  /**
   * The Blippit SDK has been started. This happens immediately when calling `Blippit.start()`. The internal state is
   * configured in this state.
   *
   * Any errors that occur in this stage will be passed to the `BlippitDelegate.blippit(_:didFailWithError:)` method.
   */
  case started

  /**
   * The internal state has been configured successfully,
   * and the Blippit SDK is waiting for the first app terminal to be found.
   */
  case lookingForAppTerminals

  /**
   * The Blippit SDK found app terminals in the vicinity, and is waiting for the user to blip on any one of them.
   */
  case appTerminalFound

  /**
   * The user has initiated a payment by blipping on one of the available app terminals. The mode-specific payload is
   * used to initiate the payment through the app terminal.
   * The user has initiated a transfer by blipping on one of the available app terminals.
   */
  case sessionInitiated
  case transferInitiated

  /**
   * The payment session is successfully completed. The transition to this state only happens momentarily before
   * The transfer is successfully completed. The transition to this state only happens momentarily before
   * transitioning back to `BlippitState.lookingForAppTerminals`.
   */
  case sessionDone
  case transferDone

  /**
   * The Blippit SDK has been stopped. It is now ready to be deallocated or started again.
   */
  case stopped
}
