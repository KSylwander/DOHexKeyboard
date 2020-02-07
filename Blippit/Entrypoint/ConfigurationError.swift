//
//  ConfigurationError.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

/**
 * Errors that may occur in relation to the Blippit configuration.
 */
enum ConfigurationError {
  /**
   * The channel passed to Podz has an invalid format.
   *
   * This error is thrown while creating the `Blippit` instance (i.e., via the
   * `BlippitSetup.setup(delegate:onBlipPayload:)` method).
   */
  case invalidChannelFormat
}

extension ConfigurationError: Error {}
