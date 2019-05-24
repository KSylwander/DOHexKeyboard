//
//  DefaultBlippitFactory.swift
//  BlippitTest
//
//  Created by Jerson Perpetua on 2019-05-24.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Blippit

struct DefaultBlippitFactory {
  let configuration: BlippitConfiguration
}

extension DefaultBlippitFactory: BlippitFactory {
  func makeBlippit(delegate: BlippitDelegate) throws -> Blippit {
    return try BlippitSetup.setup(delegate: delegate, configuration: configuration)
  }
}
