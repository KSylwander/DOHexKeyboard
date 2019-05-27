//
//  Flip.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-14.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

/* Adapted from https://github.com/robrix/Prelude/blob/master/Prelude/Flip.swift */

/* Returns a binary function which calls `f` with its arguments reversed.
 *
 * This is the function such that `flip(f)(a, b)` = `f(b, a)`.
 */
func flip<A, B, C>(_ f: @escaping (A, B) -> C) -> (B, A) -> C {
  return { a, b in f(b, a) }
}
