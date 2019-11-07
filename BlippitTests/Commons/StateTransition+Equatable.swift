//
//  StateTransition+Equatable.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-11-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

@testable import BlippitKit

extension StateTransition: Equatable {
  public static func ==(lhs: StateTransition, rhs: StateTransition) -> Bool {
    switch (lhs, rhs) {
    case let (.next(lhs), .next(rhs)):
      return lhs == rhs
    }
  }
}
