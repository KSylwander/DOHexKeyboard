//
//  URLRequest+LogDescription.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

extension URLRequest {
  enum LogStyle {
    case short
    case long
  }

  func logDescription(_ style: LogStyle) -> String {
    switch style {
    case .short:
      return "[\(httpMethod!)] \(url!.absoluteString)"
    case .long:
      return "Request [\(httpMethod!)] \(url!.absoluteString) \(allHTTPHeaderFields ?? [:])"
    }
  }
}
