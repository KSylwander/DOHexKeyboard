////
//  PropertyKey
//  BlippitKit
//
//  Copyright © 2020 Crunchfish Proximity AB. All rights reserved.
//

protocol PropertyKey {
  associatedtype Value

  static var rawValue: String { get }
  static var defaultValue: Value { get }
}
