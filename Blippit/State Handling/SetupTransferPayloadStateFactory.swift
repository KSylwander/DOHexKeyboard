//
//  SetupTransferPayloadStateFactory.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

protocol SetupTransferPayloadStateFactory {
  func makeState(delegate: StateDelegate, pid: UInt32, session: PodSession) -> State
}
