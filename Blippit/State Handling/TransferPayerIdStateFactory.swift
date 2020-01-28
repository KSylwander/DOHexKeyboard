//
//  TransferPayerIdStateFactory.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

protocol TransferPayerIdStateFactory {
  func makeState(delegate: StateDelegate, session: PodSession) -> State
}
