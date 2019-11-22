//
//  DefaultStartingStateFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import PodzKit

struct DefaultStartingStateFactory {}

extension DefaultStartingStateFactory: StartingStateFactory {
  func makeState(delegate: StateDelegate, podz: Podz) -> State {
    return StartingState(delegate: delegate, podz: podz)
  }
}
