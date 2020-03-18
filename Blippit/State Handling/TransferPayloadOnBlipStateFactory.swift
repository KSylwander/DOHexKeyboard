//
//  TransferPayloadOnBlipStateFactory.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

protocol TransferPayloadOnBlipStateFactory {
  func makeState(delegate: StateDelegate, session: PodSession) -> State
}
