//
//  Data+LogDescription.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

extension Data {
  var logDescription: String {
    guard count > 0 else {
      return "<empty>"
    }
    return String(data: self, encoding: .utf8) ?? String(describing: self)
  }
}

extension Optional where Wrapped == Data {
  var logDescription: String {
    return self?.logDescription ?? "<nil>"
  }
}
