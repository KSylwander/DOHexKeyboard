//
//  Curry.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

/* Adapted from https://github.com/robrix/Prelude/blob/master/Prelude/Curry.swift */

/* Curries a binary function `f`, producing a function which can be partially applied.
 *
 * This is the function such that `curry(f)(a)(b)` = `f(a, b)`.
 */
func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
  return { a in { b in f(a, b) } }
}
