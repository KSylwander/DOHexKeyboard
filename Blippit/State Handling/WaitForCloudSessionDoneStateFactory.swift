//
//  WaitForCloudSessionDoneStateFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-23.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import PodzKit

protocol WaitForCloudSessionDoneStateFactory {
  func makeState(delegate: StateDelegate, cloudSessionId: String, podSession: PodSession) -> State
}
