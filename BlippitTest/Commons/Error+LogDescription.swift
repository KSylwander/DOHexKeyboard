//
//  Error+LogDescription.swift
//  BlippitTest
//
//  Created by Jerson Perpetua on 2019-05-24.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

extension Error {
  var logDescription: String {
    return String(reflecting: self)
  }
}
