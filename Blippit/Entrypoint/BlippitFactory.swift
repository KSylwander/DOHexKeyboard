//
//  BlippitFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

public protocol BlippitFactory {
  func makeBlippit(delegate: BlippitDelegate, configuration: BlippitConfiguration) throws -> Blippit
}
