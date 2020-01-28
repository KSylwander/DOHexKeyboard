//
//  StateTransition.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

enum StateTransition {
  case previous(from: State)
  case next(from: StateOutput)

  case cancelled(from: State)
}
