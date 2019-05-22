//
//  DefaultSetupTransferIdStateFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

struct DefaultSetupTransferIdStateFactory {}

extension DefaultSetupTransferIdStateFactory: SetupTransferIdStateFactory {
  func makeState(delegate: StateDelegate, pid: UInt32, session: PodSession) -> State {
    return SetupTransferIdState(delegate: delegate, pid: pid, session: session)
  }
}
