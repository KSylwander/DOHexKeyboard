//
//  Composition.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-14.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

precedencegroup Composition {
  associativity: right
  higherThan: BitwiseShiftPrecedence
}
infix operator >>: Composition
infix operator >>>: Composition

func >><T, U, V>(_ f: @escaping (T) -> U, _ g: @escaping (U) -> V) -> (T) -> V {
  return { a in g(f(a)) }
}

func >><T, U, V, W>(_ f: @escaping (T) -> U, _ g: @escaping (U, V) -> W) -> (T, V) -> W {
  return { a, b in g(f(a), b) }
}

func >>><T, U, V, W>(_ f: @escaping (T, U) -> V, _ g: @escaping (V) -> W) -> (T, U) -> W {
  return { a, b in g(f(a, b)) }
}
