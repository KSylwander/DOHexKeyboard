//
//  StartingStateFactory.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

protocol StartingStateFactory {
  func makeState(delegate: StateDelegate, podz: Podz) -> State
}
