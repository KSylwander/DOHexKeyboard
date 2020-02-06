//
//  BlippitFactory.swift
//  BlippitTest
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import BlippitKit

protocol BlippitFactory {
  func makeBlippit(delegate: BlippitDelegate, payerId: String) throws -> Blippit
}
