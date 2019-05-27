//
//  DefaultHttpStatusCodeValidator.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct DefaultHttpStatusCodeValidator {}

extension DefaultHttpStatusCodeValidator: HttpStatusCodeValidator {
  func validate(_ statusCode: Int) -> Error? {
    switch statusCode {
    case 200:
      return nil
    default:
      return BlippitError.invalidHttpStatusCode(statusCode)
    }
  }
}
