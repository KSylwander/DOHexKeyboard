//
//  State+LogDescription.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-27.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
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
