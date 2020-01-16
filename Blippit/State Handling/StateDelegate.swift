//
//  StateDelegate.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol StateDelegate: AnyObject {
  func move(to transition: StateTransition)
  func state(_ state: State, didFailWithError error: Error)
}
