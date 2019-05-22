//
//  DefaultAsyncRetryHandlerFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-22.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
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
