//
//  WaitForCloudSessionDoneStateFactory.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

protocol WaitForCloudSessionDoneStateFactory {
  func makeState(delegate: StateDelegate, cloudSessionId: String, podSession: PodSession) -> State
}
