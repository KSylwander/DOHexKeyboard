//
//  TransferId+Random.swift
//  BlippitTest
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

extension TransferId {
  static let characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".map { $0 }

  static func random(in characters: [Character] = characters,
                     withLength length: Int = Int.random(in: minSize...maxSize),
                     prefix: String = "") throws -> TransferId {

    let randomLength = min(max(length - prefix.count, 0), 1000)
    let random = String((0..<randomLength).compactMap { _ in characters.randomElement() })

    return try TransferId(from: "\(prefix)\(random)")
  }
}
