//
//  URLRequest+LogDescription.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-27.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
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
