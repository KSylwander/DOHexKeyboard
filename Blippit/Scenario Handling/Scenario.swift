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

protocol NextStateFactory {
  func makeNextState(previousState: PreviousState) -> State?
}

extension Scenario where Self: NextStateFactory {
  func move(from previousState: PreviousState) {
    guard let delegate = delegate else {
      return
    }

    let nextState = makeNextState(previousState: previousState)
    delegate.scenario(self, moveTo: nextState)
  }

  func start() {
    move(from: .initial)
  }

  func stop() {
    move(from: .stopping)
    delegate?.scenario(self, didChangeBlippitState: .stopped)
  }
}

extension Scenario where Self: StateDelegate, Self: NextStateFactory {
  func state(_ state: State, moveFrom previousState: PreviousState) {
    move(from: previousState)
  }

  func state(_ state: State, didFailWithError error: Error) {
    delegate?.scenario(self, didFailWithError: error)
  }
}
