//
//  Composition.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-14.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

/* Adapted from https://github.com/robrix/Prelude/blob/master/Prelude/Compose.swift */

/* Returns the left-to-right composition of unary `g` on unary `f`.
 *
 * This is the function such that `compose(f, g)(a)` = `g(f(a))`.
 */
func compose<A, B, C>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> C) -> (A) -> C {
  return { a in g(f(a)) }
}

/* Returns the left-to-right composition of binary `g` on unary `f`.
 *
 * This is the function such that `compose(f, g)(a, b)` = `g(f(a), b)`.
 */
func compose<A, B, C, D>(_ f: @escaping (A) -> (B), _ g: @escaping (B, C) -> D) -> (A, C) -> D {
  return { a, c in g(f(a), c) }
}

/* Returns the left-to-right composition of unary `g` on binary `f`.
 *
 * This is the function such that `compose2(f, g)(a, b)` = `g(f(a, b))`.
 */
func compose2<A, B, C, D>(_ f: @escaping (A, B) -> C, _ g: @escaping (C) -> D) -> (A, B) -> D {
  return { a, b in g(f(a, b)) }
}
