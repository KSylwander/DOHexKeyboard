//
//  BlippitFactory.swift
//  BlippitTest
//
//  Created by Jerson Perpetua on 2019-05-24.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Blippit

protocol BlippitFactory {
  func makeBlippit(delegate: BlippitDelegate, userId: String) throws -> Blippit
}
