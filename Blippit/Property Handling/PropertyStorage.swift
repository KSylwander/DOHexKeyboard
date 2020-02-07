//
//  PropertyStorage.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol PropertyKey {
  associatedtype Value

  static var name: String { get }
  static var defaultValue: Value { get }
}

/* Add your app/framework-specific keys here as an extension in a different file */
enum PropertyKeys {}

final class PropertyStorage {
  private let userDefaults: UserDefaults

  init(userDefaults: UserDefaults) {
    self.userDefaults = userDefaults
  }

  func setValue<K: PropertyKey>(_ value: K.Value, for key: K.Type) {
    userDefaults.set(value, forKey: K.name)
  }

  func value<K: PropertyKey>(for key: K.Type) -> K.Value {
    return userDefaults.value(forKey: K.name).flatMap { $0 as? K.Value } ?? K.defaultValue
  }

  func removeValue<K: PropertyKey>(for key: K.Type) {
    userDefaults.removeObject(forKey: K.name)
  }
}
