//
//  EstablishCloudSessionStateFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-17.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import PodzKit

protocol EstablishCloudSessionStateFactory {
  func makeState(delegate: StateDelegate, pid: UInt32, podSession: PodSession) -> State
}
