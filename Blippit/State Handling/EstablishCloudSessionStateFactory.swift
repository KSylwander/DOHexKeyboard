//
//  EstablishCloudSessionStateFactory.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

protocol EstablishCloudSessionStateFactory {
  func makeState(delegate: StateDelegate, pid: UInt32, podSession: PodSession) -> State
}
