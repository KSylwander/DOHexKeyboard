//
//  PreviousState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

/* Previous state representations that include relevant metadata to create the corresponding next states */
enum PreviousState {
  case initial
  case cancelling
  case stopping

  case starting
  case waitForPod
  case waitForBlip(pid: UInt32, podSession: PodSession)
  case setupTransferId(pid: UInt32, podSession: PodSession)
  case establishCloudSession(cloudSessionId: String, podSession: PodSession, sessionToken: TransferId)
  case transferSessionToken(cloudSessionId: String, podSession: PodSession)
  case waitForCloudSessionDone
}

/* NOTE: Don't forget to update the `PreviousState+Equatable.swift` file in the test target when updating the cases */
