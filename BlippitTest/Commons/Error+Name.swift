//
//  Error+Name.swift
//  BlippitTest
//
//  Created by Jerson Perpetua on 2019-05-24.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

extension Error {
  var name: String {
    return String(reflecting: self)
  }
}
