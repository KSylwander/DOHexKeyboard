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

protocol TransitionStateFactory {
  func makeStartState() -> State
  func makeStopState() -> State?

  func makeState(for transition: StateTransition) -> State
}

extension Scenario where Self: TransitionStateFactory {
  func start() {
    delegate?.scenario(self, moveTo: makeStartState())
  }

  func stop() {
    delegate?.scenario(self, moveTo: makeStopState())
  }
}

extension Scenario where Self: StateDelegate, Self: TransitionStateFactory {
  func move(to transition: StateTransition) {
    guard let delegate = delegate else {
      return
    }
    let nextState = makeState(for: transition)
    delegate.scenario(self, moveTo: nextState)
  }

  func state(_ state: State, didFailWithError error: Error) {
    delegate?.scenario(self, didFailWithError: error)
  }
}
