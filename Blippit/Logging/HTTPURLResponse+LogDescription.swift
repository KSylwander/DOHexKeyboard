//
//  HTTPURLResponse.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-27.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

extension Optional where Wrapped: HTTPURLResponse {
  func logDescription(with request: URLRequest) -> String {
    guard let response = self else {
      return "No response \(request.logDescription(.short))"
    }
    return "Response \(request.logDescription(.short)) \(response.statusCode) \(response.allHeaderFields)"
  }
}
