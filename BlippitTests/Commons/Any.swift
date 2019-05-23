//
//  Any.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

func any() -> Error {
  enum Error: Swift.Error {
    case any
  }
  return Error.any
}

func any() -> Data {
  return Data(UUID().uuidString.utf8)
}
