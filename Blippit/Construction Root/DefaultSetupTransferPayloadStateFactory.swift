//
//  DefaultSetupTransferPayloadStateFactory.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

struct DefaultSetupTransferPayloadStateFactory {}

extension DefaultSetupTransferPayloadStateFactory: SetupTransferPayloadStateFactory {
  func makeState(delegate: StateDelegate, pid: UInt32, session: PodSession) -> State {
    return SetupTransferPayloadState(delegate: delegate, pid: pid, session: session)
  }
}
