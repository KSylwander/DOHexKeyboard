//
//  BluetoothError.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-11-19.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

/**
 * Errors that may occur in the BLE setup stage.
 */
public enum BluetoothError {
  /**
   * This device does not support BLE.
   *
   * This error is thrown while creating the `Blippit` instance (i.e., via the `Blippit.setup(delegate:configuration:)`
   * method).
   */
  case unsupported

  /**
   * Bluetooth is currently disabled for this device.
   *
   * Receive these errors by implementing the `BlippitDelegate.blippit(_:didFailWithError:)` method, and passing the
   * delegate implementation to the `BlippitSetup.setup(delegate:configuration:)` method.
   *
   * Blippit will continue on its own after Bluetooth is enabled.
   */
  case poweredOff

  /**
   * The app is not authorized to use the BLE peripheral/central role.
   *
   * Receive these errors by implementing the `BlippitDelegate.blippit(_:didFailWithError:)` method, and passing the
   * delegate implementation to the `BlippitSetup.setup(delegate:configuration:)` method.
   *
   * However, there is currently no way to receive this error because we don't use BLE in the background.
   */
  case unauthorized
}

extension BluetoothError: Error {}
