//
//  BlippitFactory.swift
//  BlippitTest
//
//  Created by Jerson Perpetua on 2019-05-24.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import BlippitKit

protocol BlippitFactory {
  func makeBlippit(delegate: BlippitDelegate, payerId: String) throws -> Blippit
}
