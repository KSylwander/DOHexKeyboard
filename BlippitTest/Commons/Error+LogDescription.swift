//
//  Error+LogDescription.swift
//  BlippitTest
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

extension Error {
  var logDescription: String {
    return String(reflecting: self)
  }
}
