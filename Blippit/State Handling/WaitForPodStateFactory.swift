//
//  WaitForPodStateFactory.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol WaitForPodStateFactory {
  func makeState(delegate: StateDelegate) -> State
}
