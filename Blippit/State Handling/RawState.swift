//
//  RawState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

/* State representations that include relevant metadata to create the corresponding actual states */
enum RawState {
  case initial
  case starting
  case started
  case setupTransferId(pid: UInt32, podSession: PodSession)
  case establishCloudSession(pid: UInt32, podSession: PodSession)
  case uploadCommandData(cloudSessionId: String, podSession: PodSession)
}

extension RawState: Equatable {
  static func == (lhs: RawState, rhs: RawState) -> Bool {
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
