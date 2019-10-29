//
//  DefaultBlippitFactory.swift
//  BlippitTest
//
//  Created by Jerson Perpetua on 2019-05-24.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Blippit

struct DefaultBlippitFactory {
  let podzApiKey: UUID
  let podzAppId: UUID
  let blippitApiKey: UUID
  let blippitAppId: UUID
}

extension DefaultBlippitFactory: BlippitFactory {
  func makeBlippit(delegate: BlippitDelegate, payerId: String) throws -> Blippit {
    return try BlippitSetup.setup(
      delegate: delegate,
      configuration: BlippitConfiguration(
        podzApiKey: podzApiKey,
        podzAppId: podzAppId,
        mode: .payerId(payerId)
      )
    )
  }
}
