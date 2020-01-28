//
//  AsyncRetryHandling.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

/* Allows retrying an async action `maxRetries` number of times before throwing a `maxRetriesExceededError` */
protocol AsyncRetryHandling {
  func perform(withMaxRetriesExceededError maxRetriesExceededError: Error, onError: @escaping (Error) -> Void)

  /* Resets so that subsequent retries are counted from the beginning */
  func reset()
}
