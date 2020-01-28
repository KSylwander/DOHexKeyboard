//
//  DefaultAsyncRetryHandlerFactory.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

struct DefaultAsyncRetryHandlerFactory {
  let maxRetries: Int
  let retryInterval: TimeInterval
}

extension DefaultAsyncRetryHandlerFactory: AsyncRetryHandlerFactory {
  func makeRetryHandler(action: @escaping () -> Void) -> AsyncRetryHandling {
    return RetryHandler(maxRetries: maxRetries, retryInterval: retryInterval, action: action)
  }
}
