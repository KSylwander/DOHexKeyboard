//
//  StateOutput.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import PodzKit

/* Includes relevant metadata to create the corresponding next states */
enum StateOutput {
  case starting
  case waitForPod
  case waitForBlip(pid: UInt32, podSession: PodSession)
  case setupTransferId(pid: UInt32, podSession: PodSession)

  case establishCloudSession(cloudSessionId: String, podSession: PodSession, sessionToken: TransferId)
  case transferSessionToken(cloudSessionId: String, podSession: PodSession)
  case waitForCloudSessionDone

  case transferPayerId
}

/* NOTE: Don't forget to update the `StateOutput+Equatable.swift` file in the test target when updating the cases */
