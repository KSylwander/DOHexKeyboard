//
//  PropertyKeys+Blippit
//  BlippitKit
//
//  Copyright © 2020 Crunchfish Proximity AB. All rights reserved.
//

extension PropertyKeys {
  enum Podz {
    enum Channel: PropertyKey {
      static let name = "Podz.Channel"

#if DEBUG
      static let defaultValue = "00000004"
#else
      static let defaultValue = "c562f73f"
#endif
    }
    static let channel = Channel.self
  }

  enum States {
    enum TransferPayerId {
      enum MaxRetries: PropertyKey {
        static let name = "States.TransferPayerId.MaxRetries"
        static let defaultValue = 3
      }
      static let maxRetries = MaxRetries.self
    }
  }
}
