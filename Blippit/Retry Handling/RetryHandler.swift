//
//  RetryHandler.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

final class RetryHandler {
  private let maxRetries: Int
  private var retriesRemaining: Int
  private let action: () throws -> Void

  init(maxRetries: Int, action: @escaping () throws -> Void) {
    self.maxRetries = maxRetries
    retriesRemaining = maxRetries
    self.action = action
  }
}

extension RetryHandler: RetryHandling {
  func perform(withMaxRetriesExceededError maxRetriesExceededError: Error) throws {
    guard retriesRemaining > 0 else {
      throw maxRetriesExceededError
    }
    retriesRemaining -= 1

    try action()
  }

  func reset() {
    retriesRemaining = maxRetries
  }
}
