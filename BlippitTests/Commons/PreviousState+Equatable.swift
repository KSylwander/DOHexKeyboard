//
//  PreviousState+Equatable.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

@testable import Blippit

extension PreviousState: Equatable {
  public static func ==(lhs: PreviousState, rhs: PreviousState) -> Bool {
    switch (lhs, rhs) {
    case (.initial, .initial):
      return true
    case (.cancelling, .cancelling):
      return true
    case (.stopping, .stopping):
      return true
    case (.starting, .starting):
      return true
    case (.waitForPod, .waitForPod):
      return true
    case let (.waitForBlip(lhs), .waitForBlip(rhs)),
         let (.setupTransferId(lhs), .setupTransferId(rhs)):
      return lhs.pid == rhs.pid && lhs.podSession === rhs.podSession
    case let (.establishCloudSession(lhs), .establishCloudSession(rhs)):
      return lhs.cloudSessionId == rhs.cloudSessionId
        && lhs.podSession === rhs.podSession
        && lhs.sessionToken == rhs.sessionToken
    case let (.transferSessionToken(lhs), .transferSessionToken(rhs)):
      return lhs.cloudSessionId == rhs.cloudSessionId && lhs.podSession === rhs.podSession
    case (.waitForCloudSessionDone, .waitForCloudSessionDone):
      return true
    case (.transferPayerId, .transferPayerId):
      return true
    default:
      return false
    }
  }
}
