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
  case transferDataToken(podSession: PodSession, dataToken: TransferId)
  case transferDataTokenCompleted
}

/* NOTE: Don't forget to update the `RawState+Equatable.swift` file in the test target when updating the cases */
