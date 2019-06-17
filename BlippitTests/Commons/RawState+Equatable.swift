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
    case (.waitForPod, .waitForPod):
      return true
    case (.waitForBlip, .waitForBlip):
      return true
    case let (.setupTransferId(lhs), .setupTransferId(rhs)),
         let (.establishCloudSession(lhs), .establishCloudSession(rhs)):
      return lhs.pid == rhs.pid && lhs.podSession === rhs.podSession
    case let (.transferSessionToken(lhs), .transferSessionToken(rhs)):
      return lhs.cloudSessionId == rhs.cloudSessionId
        && lhs.podSession === rhs.podSession
        && lhs.sessionToken == rhs.sessionToken
    case let (.waitForCloudSessionDone(lhs), .waitForCloudSessionDone(rhs)):
      return lhs.cloudSessionId == rhs.cloudSessionId && lhs.podSession === rhs.podSession
    case (.blippitSessionCompleted, .blippitSessionCompleted):
      return true
    default:
      return false
    }
  }
}
