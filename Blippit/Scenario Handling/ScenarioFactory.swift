//
//  ScenarioFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-10-23.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

protocol ScenarioFactory {
  func makeScenario(delegate: ScenarioDelegate) -> Scenario
}
