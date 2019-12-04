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
      static let apiKey = UUID(uuidString: "B6FF07D1-C5A0-438E-9202-44B92F7BBB09")!
      static let appId = UUID(uuidString: "81B56222-084E-44C4-8C36-AA2E6F69E8FD")!
#elseif STAGE
      static let apiKey = UUID(uuidString: "CF2A0178-E4BD-47F9-A508-4E50F4113BAD")!
      static let appId = UUID(uuidString: "CF000000-0000-0000-0000-000000000004")!
#else
      static let apiKey = UUID(uuidString: "CF2A0178-E4BD-47F9-A508-4E50F4113BAD")!
      static let appId = UUID(uuidString: "CF000000-0000-0000-0000-000000000004")!
#endif
    }
  }
}
