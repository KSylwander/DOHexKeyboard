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
    enum defaults {
      static let basePath = ""

      static let cachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy
      static let timeoutInterval = TimeInterval(60.0)
    }
  }
}
