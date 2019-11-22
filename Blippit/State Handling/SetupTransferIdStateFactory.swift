//
//  SetupTransferIdStateFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import PodzKit

protocol SetupTransferIdStateFactory {
  func makeState(delegate: StateDelegate, pid: UInt32, session: PodSession) -> State
}
