//
//  Application.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-14.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

func apply<A, B>(_ a: A, _ f: (A) -> B) -> B {
  return f(a)
}
