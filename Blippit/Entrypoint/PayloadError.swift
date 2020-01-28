//
//  PayloadError.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

/**
 * Errors that may occur in relation to the transfer payload.
 *
 * These errors can be received by:
 *
 * 1. Implementing the `BlippitDelegate.blippit(_:didFailWithError:)` method, and passing the delegate implementation
 *    to the `BlippitSetup.setup(delegate:configuration:)` method.
 * 2. Performing a do-catch around the `BlippitSetup.setup(delegate:configuration:)` method.
 */
public enum PayloadError {
  /**
   * The payload is either too short or too long. Valid length is between 1 and 128 characters.
   */
  case invalidLength

  /**
   * The payload contains invalid characters. As of writing, all transfer payloads should be alphanumeric.
   */
  case invalidFormat
}

extension PayloadError: Error {}
