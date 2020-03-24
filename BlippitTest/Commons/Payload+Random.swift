//
//  Payload+Random.swift
//  BlippitTest
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import BlippitKit
import PodzKit

extension BlippitKit.Payload {
  static let characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".map { $0 }

  static func random(in characters: [Character] = characters,
                     withLength length: Int = Int.random(in: PodzKit.Payload.minSize...PodzKit.Payload.maxSize),
                     prefix: String = "") throws -> BlippitKit.Payload {

    let randomLength = min(max(length - prefix.count, 0), 1000)
    let random = String((0..<randomLength).compactMap { _ in characters.randomElement() })

    return try Payload(containing: "\(prefix)\(random)")
  }
}
