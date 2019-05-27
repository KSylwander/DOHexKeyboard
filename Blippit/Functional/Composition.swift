//
//  Composition.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-14.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

func compose<A, B, C>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> C) -> (A) -> C {
  return { a in g(f(a)) }
}

func compose<A, B, C, D>(_ f: @escaping (A) -> (B), _ g: @escaping (B, C) -> D) -> (A, C) -> D {
  return { a, c in g(f(a), c) }
}

func compose2<A, B, C, D>(_ f: @escaping (A, B) -> C, _ g: @escaping (C) -> D) -> (A, B) -> D {
  return { a, b in g(f(a, b)) }
}
