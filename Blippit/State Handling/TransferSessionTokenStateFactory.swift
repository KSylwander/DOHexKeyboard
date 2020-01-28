//
//  TransferSessionTokenStateFactory.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

protocol TransferSessionTokenStateFactory {
  func makeState(delegate: StateDelegate,
                 cloudSessionId: String,
                 session: PodSession,
                 sessionToken: TransferId) -> State
}
