//
//  Constants+Credentials.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-10-30.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

extension Constants {
  enum Credentials {
    enum Podz {
#if PRODUCTION
      static let channel = "c562f73f"
#elseif STAGE
      static let channel = "00000004"
#else
      static let channel = "00000004"
#endif
    }
  }
}
