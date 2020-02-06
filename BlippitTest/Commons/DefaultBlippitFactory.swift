//
//  DefaultBlippitFactory.swift
//  BlippitTest
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import BlippitKit

struct DefaultBlippitFactory {}

extension DefaultBlippitFactory: BlippitFactory {
  func makeBlippit(delegate: BlippitDelegate, payerId: String) throws -> Blippit {
    return try BlippitSetup.setup(delegate: delegate, onBlipPayload: Payload(containing: payerId))
  }
}
