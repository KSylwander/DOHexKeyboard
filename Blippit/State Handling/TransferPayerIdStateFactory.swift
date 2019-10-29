//
//  TransferPayerIdStateFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-10-17.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

protocol TransferPayerIdStateFactory {
  func makeState(delegate: StateDelegate, session: PodSession) -> State
}
