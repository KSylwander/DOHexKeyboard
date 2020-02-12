//
//  StateTransition+Equatable.swift
//  BlippitTests
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

@testable import BlippitKit

extension StateTransition: Equatable {
  public static func ==(lhs: StateTransition, rhs: StateTransition) -> Bool {
    switch (lhs, rhs) {
    case let (.next(lhs), .next(rhs)):
      return lhs == rhs
    case let (.cancelled(lhs), .cancelled(rhs)):
      return type(of: lhs) == type(of: rhs)
    default:
      return false
    }
  }
}
