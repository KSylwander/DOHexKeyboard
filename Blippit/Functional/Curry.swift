//
//  Curry.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-14.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

func curry<T, U, V>(_ f: @escaping (T, U) -> V) -> (T) -> (U) -> V {
  return { a in { b in f(a, b) } }
}
