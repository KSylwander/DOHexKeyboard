//
//  HTTPURLResponse.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
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
