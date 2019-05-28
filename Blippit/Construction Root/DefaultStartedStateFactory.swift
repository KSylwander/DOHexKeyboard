//
//  DefaultStartedStateFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct DefaultStartedStateFactory {}

extension DefaultStartedStateFactory: StartedStateFactory {
  func makeState(delegate: StateDelegate) -> State {
    return StartedState(delegate: delegate)
  }
}
