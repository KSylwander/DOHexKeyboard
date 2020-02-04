//
//  ApiConfig.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

struct ApiConfig {
  let method: HttpMethod

  /* Trailing slash on base path required */
  let basePath: String

  let resource: String

  let contentType: String

  let cachePolicy: URLRequest.CachePolicy
  let timeoutInterval: TimeInterval
}
