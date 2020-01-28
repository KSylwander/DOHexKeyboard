//
//  Constants+Networking.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

extension Constants {
  enum Api {
    static let version = "0"

    enum Defaults {
      /* Trailing slash on base path required */
#if PRODUCTION
      static let basePath = "https://prod-bsac.bubbelskum.com/api/\(version)/"
#elseif STAGE
      static let basePath = "https://stage-bsac.bubbelskum.com/api/\(version)/"
#else
      static let basePath = "https://dev-bsac.bubbelskum.com/api/\(version)/"
#endif

      static let contentType = "application/json"

      static let cachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy
      static let timeoutInterval = TimeInterval(60.0)
    }

    enum EstablishCloudSession {
      static let config = ApiConfig(
        method: .post,
        resource: "session"
      )
    }

    enum GetCloudSessionStatus {
      static let config = ApiConfig(
        method: .get,
        resource: "session/%@/status")
    }
  }
}
