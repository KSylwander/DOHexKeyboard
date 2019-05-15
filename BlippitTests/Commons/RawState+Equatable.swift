//
//  RawState+Equatable.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

@testable import Blippit

extension RawState: Equatable {
  public static func ==(lhs: RawState, rhs: RawState) -> Bool {
    switch (lhs, rhs) {
    case (.initial, .initial):
      return true
    case (.starting, .starting):
      return true
    case (.started, .started):
      return true
    case let (.setupTransferId(lhs), .setupTransferId(rhs)),
         let (.establishCloudSession(lhs), .establishCloudSession(rhs)):
      return lhs.pid == rhs.pid && lhs.podSession === rhs.podSession
    case let (.uploadCommandData(lhs), .uploadCommandData(rhs)):
      return lhs.cloudSessionId == rhs.cloudSessionId && lhs.podSession === rhs.podSession
    default:
      return false
    }
  }
}
