//
//  RetryHandler.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

final class RetryHandler {
  private let maxRetries: Int
  private var retriesRemaining: Int

  private let retryInterval: TimeInterval
  private let action: () throws -> Void

  init(maxRetries: Int, retryInterval: TimeInterval = 0.0, action: @escaping () throws -> Void) {
    self.maxRetries = maxRetries
    retriesRemaining = maxRetries

    self.retryInterval = retryInterval
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
