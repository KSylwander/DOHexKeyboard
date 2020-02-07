//
//  StateOutput.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

/* Includes relevant metadata to create the corresponding next states */
enum StateOutput {
  case starting
  case waitForPod
  case waitForBlip(pid: UInt32, podSession: PodSession)
  case setupTransferId(pid: UInt32, podSession: PodSession)
  case transferPayerId
}

/* NOTE: Don't forget to update the `StateOutput+Equatable.swift` file in the test target when updating the cases */
