//
//  ConfigurationError.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

/**
 * Errors that may occur in relation to the Blippit configuration.
 */
enum ConfigurationError {
  /**
   * The API credentials cannot be verified. Check that the API key and app ID pair passed to the Blippit
   * configuration is up-to-date. If your Blippit credentials is valid, report this problem to Blippit support.
   */
  case invalidCredentials

  /**
   * The channel passed to Podz has an invalid format.
   *
   * This error is thrown while creating the `Blippit` instance (i.e., via the
   * `BlippitSetup.setup(delegate:configuration:)` method).
   */
  case invalidChannelFormat
}

extension ConfigurationError: Error {}
