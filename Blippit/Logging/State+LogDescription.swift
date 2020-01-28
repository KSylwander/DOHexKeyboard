//
//  State+LogDescription.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

extension State {
  var logDescription: String {
    return String(describing: type(of: self))
  }
}

extension Optional where Wrapped == State {
  var logDescription: String {
    return self?.logDescription ?? "<nil>"
  }
}
