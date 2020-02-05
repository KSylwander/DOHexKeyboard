//
//  PropertyStorage.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish. All rights reserved.
//

import Foundation

final class PropertyStorage {
  private let userDefaults: UserDefaults

  init(userDefaults: UserDefaults) {
    self.userDefaults = userDefaults
  }

  func setValue<K: PropertyKey>(_ value: K.Value, for key: K.Type) {
    userDefaults.set(value, forKey: K.rawValue)
  }

  func value<K: PropertyKey>(for key: K.Type) -> K.Value {
    return userDefaults.value(forKey: K.rawValue).flatMap { $0 as? K.Value } ?? K.defaultValue
  }

  func removeValue<K: PropertyKey>(for key: K.Type) {
    userDefaults.removeObject(forKey: K.rawValue)
  }
}
