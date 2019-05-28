//
//  StartingStateFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

protocol StartingStateFactory {
  func makeState(delegate: StateDelegate, podz: Podz) -> State
}
