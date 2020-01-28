//
//  ScenarioFactory.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

protocol ScenarioFactory {
  func makeScenario(delegate: ScenarioDelegate) -> Scenario
}
