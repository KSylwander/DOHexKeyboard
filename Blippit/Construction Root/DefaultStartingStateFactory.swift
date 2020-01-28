//
//  DefaultStartingStateFactory.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

struct DefaultStartingStateFactory {}

extension DefaultStartingStateFactory: StartingStateFactory {
  func makeState(delegate: StateDelegate, podz: Podz) -> State {
    return StartingState(delegate: delegate, podz: podz)
  }
}
