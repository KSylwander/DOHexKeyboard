//
//  Error+Name.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

extension Error {
  var logDescription: String {
    return String(reflecting: self)
  }
}

extension Optional where Wrapped: Error {
  var logDescription: String {
    return self?.logDescription ?? "<nil>"
  }
}
