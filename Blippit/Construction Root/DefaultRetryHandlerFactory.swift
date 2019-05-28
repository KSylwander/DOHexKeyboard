//
//  DefaultRetryHandlerFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
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
