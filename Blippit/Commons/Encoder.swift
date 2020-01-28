//
//  Encoder.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol Encoder {
  func encode<T>(_ value: T) throws -> Data where T: Encodable
}

extension JSONEncoder: Encoder {}
