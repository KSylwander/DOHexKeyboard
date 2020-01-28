//
//  DefaultBlippitFactory.swift
//  BlippitTest
//
//  Created by Jerson Perpetua on 2019-05-24.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import BlippitKit

struct DefaultBlippitFactory {
  let apiKey: UUID
  let appId: UUID
}

extension DefaultBlippitFactory: BlippitFactory {
  func makeBlippit(delegate: BlippitDelegate, payerId: String) throws -> Blippit {
    return try BlippitSetup.setup(delegate: delegate, onBlipPayload: Payload(value: payerId))
  }
}
