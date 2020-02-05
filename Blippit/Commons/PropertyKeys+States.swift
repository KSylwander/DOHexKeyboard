////
//  PropertyKeys+States
//  BlippitKit
//
//  Copyright © 2020 Crunchfish Proximity AB. All rights reserved.
//

extension PropertyKeys {
  enum States {
    enum TransferPayerId {
      enum MaxRetries: PropertyKey {
        static let rawValue = "States.TransferPayerId.MaxRetries"
        static let defaultValue = 3
      }
      static let maxRetries = MaxRetries.self
    }
  }
}
