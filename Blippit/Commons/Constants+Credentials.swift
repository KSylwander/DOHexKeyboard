//
//  Constants+Credentials.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

extension Constants {
  enum Credentials {
    enum Podz {
#if DEBUG
      static let channel = "00000004"
#else
      static let channel = "c562f73f"
#endif
    }
  }
}
