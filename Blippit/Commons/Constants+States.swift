//
//  Constants+States.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

extension Constants {
  enum states {
    enum establishCloudSession {
      static let maxRetries = 3
      static let retryInterval = TimeInterval(1.0)
    }

    enum transferSessionToken {
      static let maxRetries = 3
    }

    enum waitForCloudSessionDone {
      static let maxRetries = 3
      static let retryInterval = TimeInterval(1.0)

      static let pollInterval = TimeInterval(1.0)
    }

    enum transferCloudSessionDoneToken {
      static let maxRetries = 3
    }
  }
}
