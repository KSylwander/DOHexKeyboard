//
//  ScenarioDelegate.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

protocol ScenarioDelegate: AnyObject {
  func scenario(_ scenario: Scenario, moveTo state: State?)
  func scenario(_ scenario: Scenario, didFailWithError error: Error)

  func scenario(_ scenario: Scenario, didChangeBlippitState blippitState: BlippitState)
}
