//
//  BluetoothError.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

/**
 * Errors that may occur in the BLE setup stage.
 */
public enum BluetoothError {
  /**
   * This device does not support BLE.
   *
   * This error is thrown while creating the `Blippit` instance (i.e., via the
   * `BlippitSetup.setup(delegate:onBlipPayload:)` method).
   */
  case unsupported

  /**
   * Bluetooth is currently disabled for this device.
   *
   * Receive these errors by implementing the `BlippitDelegate.blippit(_:didFailWithError:)` method, and passing the
   * delegate implementation to the `BlippitSetup.setup(delegate:onBlipPayload:)` method.
   *
   * Blippit will continue on its own after Bluetooth is enabled.
   */
  case poweredOff

  /**
   * The app is not authorized to use the BLE peripheral/central role. Can only happen for iOS versions less than 13.0.
   *
   * Receive these errors by implementing the `BlippitDelegate.blippit(_:didFailWithError:)` method, and passing the
   * delegate implementation to the `BlippitSetup.setup(delegate:onBlipPayload:)` method.
   */
  case unauthorized

  /**
   * The app is not authorized to use Bluetooth. Can only happen for iOS 13.0 and up.
   *
   * Receive these errors by implementing `BlippitDelegate.blippit(_:didFailWithError:)` method, and passing the
   * delegate implementation to the `BlippitSetup.setup(delegate:onBlipPayload:)` method.
   *
   * The user can't change the Bluetooth authorization status when this error is received, possibly due to active
   * restrictions such as parental controls.
   */
  case restricted

  /**
   * The user explicitly denied Bluetooth access for this app. Can only happen for iOS 13.0 and up.
   *
   * Receive these errors by implementing `BlippitDelegate.blippit(_:didFailWithError:)` method, and passing the
   * delegate implementation to the `BlippitSetup.setup(delegate:onBlipPayload:)` method.
   *
   * Blippit will continue on its own after Bluetooth is granted access.
   */
  case denied
}

extension BluetoothError: Error {}
