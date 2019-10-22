//
//  Scenario.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-10-22.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

protocol Scenario {
  func nextState(for previousState: PreviousState, delegate: StateDelegate) -> State?
}
