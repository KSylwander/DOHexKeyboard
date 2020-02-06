//
//  PropertyKeys+Podz
//  BlippitKit
//
//  Copyright © 2020 Crunchfish Proximity AB. All rights reserved.
//

extension PropertyKeys {
  enum Podz {
    enum Channel: PropertyKey {
      static let rawValue = "Podz.Channel"

#if DEBUG
      static let defaultValue = "00000004"
#else
      static let defaultValue = "c562f73f"
#endif
    }
    static let channel = Channel.self
  }
}
