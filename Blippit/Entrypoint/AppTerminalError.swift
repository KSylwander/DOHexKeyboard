//
//  AppTerminalError.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

/**
 * Errors that may occur in relation to an app terminal.
 *
 * Receive these errors by implementing the `BlippitDelegate.blippit(_:didFailWithError:)` method, and passing the
 * delegate implementation to the `BlippitSetup.setup(delegate:onBlipPayload:)` method.
 */
public enum AppTerminalError {
  /**
   * Transfer of payload failed after several attempts. May be fixed by asking the user to blip again.
   */
  case transferFailed

  /**
   * The app terminal already has an active connection. May be fixed by asking the user to blip again.
   */
  case busy

  /**
   * The connection to the app terminal was closed unexpectedly due to possible interruptions in the BLE signal. May
   * be fixed by asking the user to blip again.
   */
  case connectionLost

  /**
   * A connection to a different app terminal has already been established.
   */
  case concurrentConnections
}

extension AppTerminalError: Error {}

enum InternalAppTerminalError {
  /**
   * The blipped app terminal does not support transferring of data. Ask the user to try a different app terminal.
   */
  case unsupported
}

extension InternalAppTerminalError: Error {}
