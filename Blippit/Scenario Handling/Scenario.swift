//
//  Scenario.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-10-22.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

protocol Scenario {
  var delegate: ScenarioDelegate? { get }

  func start()
  func stop()
}
