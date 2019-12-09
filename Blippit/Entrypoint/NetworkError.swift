//
//  NetworkError.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-11-19.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

/**
 * Errors that may occur in relation to the network connection.
 *
 * Receive these errors by implementing the `BlippitDelegate.blippit(_:didFailWithError:)` method, and passing the
 * delegate implementation to the `BlippitSetup.setup(delegate:configuration:)` method.
 */
public enum NetworkError {
  /**
   * The network connection is unreachable. Ask the user to connect to the internet.
   *
   * Blippit will continue on its own when the internet becomes reachable.
   */
  case unreachable
}

extension NetworkError: Error {}

// swiftlint:disable todo
/* TODO: Merge to `NetworkError` when `_BlippitMode.payment` is exposed publicly */
// swiftlint:enable todo
enum _NetworkError {
  case invalidHttpStatusCode(Int, responseData: Data?)
}

extension _NetworkError: Error {}
