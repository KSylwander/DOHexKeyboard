//
//  Fmap.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-14.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

func fmap<T, U>(_ f: (T) -> U, _ a: T?) -> U? {
  return a.map(f)
}
