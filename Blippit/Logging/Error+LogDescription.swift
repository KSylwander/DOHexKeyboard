//
//  Error+Name.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-22.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
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
