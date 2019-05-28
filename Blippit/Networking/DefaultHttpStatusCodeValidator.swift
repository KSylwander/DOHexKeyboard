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
    case 401:
      /* Invalid API key */
      return BlippitError.invalidCredentials
    case 400:
      /* Generic bad request error */
      fallthrough
    case 404:
      /* Invalid app ID */
      return BlippitError.invalidHttpStatusCode(statusCode)
    default:
      return nil
    }
  }
}
