//
//  Scenario.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

protocol Scenario {
  var delegate: ScenarioDelegate? { get }

  func start()
  func stop()
}
