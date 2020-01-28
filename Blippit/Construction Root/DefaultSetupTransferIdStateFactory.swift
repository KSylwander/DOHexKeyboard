//
//  DefaultSetupTransferIdStateFactory.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

struct DefaultSetupTransferIdStateFactory {}

extension DefaultSetupTransferIdStateFactory: SetupTransferIdStateFactory {
  func makeState(delegate: StateDelegate, pid: UInt32, session: PodSession) -> State {
    return SetupTransferIdState(delegate: delegate, pid: pid, session: session)
  }
}
