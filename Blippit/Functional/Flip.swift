//
//  Flip.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-14.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

func flip<T, U, V>(_ f: @escaping (T, U) -> V) -> (U, T) -> V {
  return { a, b in f(b, a) }
}
