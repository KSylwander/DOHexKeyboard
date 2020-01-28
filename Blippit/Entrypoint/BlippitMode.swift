//
//  BlippitMode.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

/**
 * Mode determining the behaviour of the Blippit SDK.
 *
 * Customize by setting it on a `BlippitConfiguration` instance, and passing the configuration to the
 * `BlippitSetup.setup(delegate:configuration:)` method.
 */
public enum BlippitMode {
  /**
   * Transfer a payer ID on blip. The payer ID string passed to this mode must be alphanumeric
   * (i.e., `[a-zA-Z0-9]{1,128}`).
   */
  case payerId(String)
}

// swiftlint:disable todo
/* TODO: Remove when `.payment` is exposed publicly */
// swiftlint:enable todo
enum _BlippitMode {
  case payment(apiKey: UUID, appId: UUID, serviceInfo: ServiceInfo)
  case payerId(String)

  init(_ mode: BlippitMode) {
    switch mode {
    case let .payerId(value):
      self = .payerId(value)
    }
  }
}
