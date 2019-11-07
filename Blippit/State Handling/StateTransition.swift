//
//  StateTransition.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-11-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

enum StateTransition {
  case next(from: StateOutput)

  case cancelled(from: State)
}
