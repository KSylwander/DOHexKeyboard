//
//  BlippitState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-06-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

public enum BlippitState {
  case started

  case lookingForAppTerminals
  case appTerminalFound

  case sessionInitiated
  case sessionDone

  case stopped
}
