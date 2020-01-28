//
//  RetryHandling.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

/* Allows retrying an action `maxRetries` number of times before throwing a `maxRetriesExceededError` */
protocol RetryHandling {
  func perform(withMaxRetriesExceededError maxRetriesExceededError: Error) throws

  /* Resets so that subsequent retries are counted from the beginning */
  func reset()
}
