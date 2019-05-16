//
//  TransferDataTokenStateFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

protocol TransferDataTokenStateFactory {
  func makeState(delegate: StateDelegate, session: PodSession, dataToken: TransferId) -> State
}
