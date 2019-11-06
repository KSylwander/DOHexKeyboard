//
//  BlippitMode.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-10-17.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
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

/* TODO: Remove when `.payment` is exposed publicly */
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
