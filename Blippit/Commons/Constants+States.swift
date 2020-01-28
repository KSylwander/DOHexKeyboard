//
//  Constants+States.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

extension Constants {
  enum States {
    enum EstablishCloudSession {
      static let maxRetries = 3
      static let retryInterval = TimeInterval(1.0)
    }

    enum TransferSessionToken {
      static let maxRetries = 3
    }

    enum WaitForCloudSessionDone {
      static let maxRetries = 3
      static let retryInterval = TimeInterval(1.0)

      static let pollInterval = TimeInterval(1.0)
    }

    enum TransferPayerId {
      static let maxRetries = 3
    }
  }
}
