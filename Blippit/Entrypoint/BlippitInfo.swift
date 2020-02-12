//
//  BlippitInfo.swift
//  BlippitKitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

/**
 Contains information about BlippitKit.
 */
public enum BlippitInfo {
  /**
   Returns the current version of this framework.
   */
  public static let versionName: String = {
    let bundle = Bundle(for: BundleLocator.self)
    if let build = bundle.infoDictionary?["CFBundleShortVersionString"] as? String {
      return build
    }
    return "version not found"
  }()
}
