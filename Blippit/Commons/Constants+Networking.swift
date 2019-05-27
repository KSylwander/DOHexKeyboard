//
//  Constants+Networking.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-14.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

extension Constants {
  enum api {
    static let version = "0.1.0"

    enum defaults {
#if DEBUG
      static let basePath = "https://stage-bsac.bubbelskum.com/api/\(version)"
#else
      static let basePath = "https://prod-bsac.bubbelskum.com/api/\(version)"
#endif

      static let cachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy
      static let timeoutInterval = TimeInterval(60.0)
    }

    enum establishCloudSession {
      static let config = ApiConfig(
        method: .post,
        resource: "user/establishSession"
      )
    }

    enum uploadCommandData {
      static let config = ApiConfig(
        method: .get,
        resource: "user/uploadCommandData"
      )
    }

    enum getCloudSessionStatus {
      static let config = ApiConfig(
        method: .get,
        resource: "session/%@/status")
    }
  }
}
