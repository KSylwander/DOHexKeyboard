//
//  DefaultRetryHandlerFactory.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

struct DefaultRetryHandlerFactory {
  let maxRetries: Int
}

extension DefaultRetryHandlerFactory: RetryHandlerFactory {
  func makeRetryHandler(action: @escaping () throws -> Void) -> RetryHandling {
    return RetryHandler(maxRetries: maxRetries, action: action)
  }
}
