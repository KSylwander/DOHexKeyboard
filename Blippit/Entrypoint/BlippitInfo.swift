//
//  BlippitInfo.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

/**
 Contains information about the Blippit SDK.
 */
public enum BlippitInfo {
  /**
   Returns the current version of this framework.
   */
  public static let versionName: String = {
    let bundle = Bundle(for: BlippitBundle.self)
    if let build = bundle.infoDictionary?["CFBundleShortVersionString"] as? String {
      return build
    }
    return "version not found"
  }()

  private class BlippitBundle {}
}
