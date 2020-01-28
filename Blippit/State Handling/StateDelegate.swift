//
//  StateDelegate.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol StateDelegate: AnyObject {
  func move(to transition: StateTransition)
  func state(_ state: State, didFailWithError error: Error)
}
