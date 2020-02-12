//
//  StateOutput+Equatable.swift
//  BlippitTests
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

@testable import BlippitKit

extension StateOutput: Equatable {
  public static func ==(lhs: StateOutput, rhs: StateOutput) -> Bool {
    switch (lhs, rhs) {
    case (.starting, .starting):
      return true
    case (.waitForPod, .waitForPod):
      return true
    case let (.waitForBlip(lhs), .waitForBlip(rhs)),
         let (.setupTransferId(lhs), .setupTransferId(rhs)):
      return lhs.pid == rhs.pid && lhs.podSession === rhs.podSession
    case (.transferPayerId, .transferPayerId):
      return true
    default:
      return false
    }
  }
}
