//
//  AppTerminalError.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-11-19.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

/**
 * Errors that may occur in connection to an app terminal.
 *
 * Receive these errors by implementing the `BlippitDelegate.blippit(_:didFailWithError:)` method, and passing the
 * delegate implementation to the `BlippitSetup.setup(delegate:configuration:)` method.
 */
public enum AppTerminalError {
  /**
   * The blipped app terminal does not support transferring of data. Ask the user to try a different app terminal.
   */
  case unsupported

  /**
   * Transfer of payload failed after several attempts. May be fixed by asking the user to blip again.
   */
  case transferFailed

  /**
   * The connection to the app terminal was closed unexpectedly due to possible interruptions in the BLE signal. May
   * be fixed by asking the user to blip again.
   */
  case connectionLost
}

extension AppTerminalError: Error {}
