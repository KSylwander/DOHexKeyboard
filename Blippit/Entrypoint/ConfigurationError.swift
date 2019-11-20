//
//  ConfigurationError.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-11-19.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
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
}

extension ConfigurationError: Error {}
