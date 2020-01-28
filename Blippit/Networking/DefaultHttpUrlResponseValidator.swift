//
//  DefaultHttpUrlResponseValidator.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
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
      return ConfigurationError.invalidCredentials
    default:
      /* Everything else is an error */
      return NetworkError.invalidHttpStatusCode(response.statusCode, responseData: data)
    }
  }
}
