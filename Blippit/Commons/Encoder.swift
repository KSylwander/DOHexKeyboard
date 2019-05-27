//
//  Encoder.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol Encoder {
  func encode<T>(_ value: T) throws -> Data where T: Encodable
}
