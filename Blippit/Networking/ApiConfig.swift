//
//  ApiConfig.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-14.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct ApiConfig {
  let method: HttpMethod
  let basePath = Constants.api.defaults.basePath
  let resource: String

  let contentType = Constants.api.defaults.contentType

  let cachePolicy = Constants.api.defaults.cachePolicy
  let timeoutInterval = Constants.api.defaults.timeoutInterval
}
