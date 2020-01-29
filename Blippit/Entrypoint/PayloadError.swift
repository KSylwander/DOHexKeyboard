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
 *    to the `BlippitSetup.setup(delegate:onBlipPayload:)` method.
 * 2. Performing a do-catch around the `BlippitSetup.setup(delegate:onBlipPayload:)` method.
 */
public enum PayloadError {
  /**
   * The payload is either too short or too long. Valid length is [1,128] characters.
   */
  case invalidLength

  /**
   * The payload contains invalid characters. All transfer payloads should be alphanumeric.
   */
  case invalidFormat
}

extension PayloadError: Error {}
