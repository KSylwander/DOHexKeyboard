//
//  Application.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-14.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

precedencegroup ForwardApplication {
  associativity: left
  higherThan: AssignmentPrecedence
}
infix operator |>: ForwardApplication

func |><T, U>(_ a: T, _ f: (T) -> U) -> U {
  return f(a)
}
