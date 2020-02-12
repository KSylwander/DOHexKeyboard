//
//  PropertyStorage+Shared
//  BlippitKit
//
//  Copyright © 2020 Crunchfish Proximity AB. All rights reserved.
//

extension PropertyStorage {
  static var shared: PropertyStorage {
    let bundle = Bundle(for: NSClassFromString("BlippitKit.BundleLocator")!)
    let userDefaults = UserDefaults(suiteName: bundle.bundleIdentifier)!

    return PropertyStorage(userDefaults: userDefaults)
  }
}
