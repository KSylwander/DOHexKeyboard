//
//  DefaultHttpUrlResponseValidator.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct DefaultHttpUrlResponseValidator {}

extension DefaultHttpUrlResponseValidator: HttpUrlResponseValidator {
  func validate(_ response: HTTPURLResponse, data: Data?) -> Error? {
    switch response.statusCode {
    case 401:
      /* Invalid API key */
      return BlippitError.invalidCredentials(data: data)
    case 400:
      /* Generic bad request error */
      fallthrough
    case 404:
      /* Invalid app ID */
      return BlippitError.invalidHttpStatusCode(response.statusCode, data: data)
    default:
      return nil
    }
  }
}
