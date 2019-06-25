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
    case 200..<300:
      /* Valid status codes */
      return nil
    case 401:
      /* Invalid API key */
      return BlippitError.invalidCredentials(responseData: data)
    default:
      /* Everything else is an error */
      return BlippitError.invalidHttpStatusCode(response.statusCode, responseData: data)
    }
  }
}
