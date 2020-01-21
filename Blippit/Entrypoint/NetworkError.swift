//
//  NetworkError.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-11-19.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

/**
 * Errors that may occur in relation to the network connection.
 *
 * Receive these errors by implementing the `BlippitDelegate.blippit(_:didFailWithError:)` method, and passing the
 * delegate implementation to the `BlippitSetup.setup(delegate:configuration:)` method.
 */
enum NetworkError {
  /**
   * The server returned an invalid HTTP status code.
   *
   * May be fixed by asking the user to blip again.
   */
  case invalidHttpStatusCode(Int, responseData: Data?)
}

extension NetworkError: Error {}
