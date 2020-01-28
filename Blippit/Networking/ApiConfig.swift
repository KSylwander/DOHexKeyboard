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
  let basePath = Constants.Api.Defaults.basePath

  let resource: String

  let contentType = Constants.Api.Defaults.contentType

  let cachePolicy = Constants.Api.Defaults.cachePolicy
  let timeoutInterval = Constants.Api.Defaults.timeoutInterval
}
