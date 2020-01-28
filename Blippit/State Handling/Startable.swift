//
//  Startable.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

/* Conforming states can be started */
protocol Startable: AnyObject {
  func start()
}
