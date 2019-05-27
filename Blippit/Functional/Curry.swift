//
//  Curry.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-14.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
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
