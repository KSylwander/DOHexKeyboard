//
//  WaitForBlipStateFactory.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol WaitForBlipStateFactory {
  func makeState(delegate: StateDelegate) -> State
}
