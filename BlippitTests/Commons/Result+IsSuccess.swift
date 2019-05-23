//
//  Result+IsSuccess.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

extension Result {
  var isSuccess: Bool {
    guard case .success = self else {
      return false
    }
    return true
  }
}
