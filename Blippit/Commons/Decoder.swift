//
//  Decoder.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol Decoder {
  func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}
