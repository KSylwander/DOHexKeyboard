//
//  BaseScenario.swift
//  BlippitKit
//
//  Created by Jerson Perpetua on 2020-01-10.
//  Copyright © 2020 Crunchfish AB. All rights reserved.
//

import PodzKit

class BaseScenario {
  private(set) weak var delegate: ScenarioDelegate?

  let podz: Podz

  let startingStateFactory: StartingStateFactory
  let waitForPodStateFactory: WaitForPodStateFactory
  let waitForBlipStateFactory: WaitForBlipStateFactory
  let setupTransferIdStateFactory: SetupTransferIdStateFactory

  init(delegate: ScenarioDelegate,
       podz: Podz,
       startingStateFactory: StartingStateFactory,
       waitForPodStateFactory: WaitForPodStateFactory,
       waitForBlipStateFactory: WaitForBlipStateFactory,
       setupTransferIdStateFactory: SetupTransferIdStateFactory) {

    self.delegate = delegate
    self.podz = podz
    self.startingStateFactory = startingStateFactory
    self.waitForPodStateFactory = waitForPodStateFactory
    self.waitForBlipStateFactory = waitForBlipStateFactory
    self.setupTransferIdStateFactory = setupTransferIdStateFactory
  }

  func makeStartState() -> State {
    delegate?.scenario(self, didChangeBlippitState: .started)
    return startingStateFactory.makeState(delegate: self, podz: podz)
  }

  func makeStopState() -> State? {
    delegate?.scenario(self, didChangeBlippitState: .stopped)
    return nil
  }

  final func makeState(for transition: StateTransition) -> State {
    switch transition {
    case let .previous(from: state):
      return makePreviousState(from: state)
    case let .next(from: stateOutput):
      return makeNextState(from: stateOutput)
    case let .cancelled(from: state):
      return makeCancelledState(from: state)
    }
  }

  func makePreviousState(from state: State) -> State {
    switch state {
    case is WaitForBlipState:
      delegate?.scenario(self, didChangeBlippitState: .lookingForAppTerminals)
      return waitForPodStateFactory.makeState(delegate: self)
    default:
      fatalError("Unsupported next state: \(state.logDescription)")
    }
  }

  func makeNextState(from stateOutput: StateOutput) -> State {
    switch stateOutput {
    case .starting:
      delegate?.scenario(self, didChangeBlippitState: .lookingForAppTerminals)
      return waitForPodStateFactory.makeState(delegate: self)
    case .waitForPod:
      delegate?.scenario(self, didChangeBlippitState: .appTerminalFound)
      return waitForBlipStateFactory.makeState(delegate: self)
    case let .waitForBlip(pid, podSession):
      delegate?.scenario(self, didChangeBlippitState: .sessionInitiated)
      return setupTransferIdStateFactory.makeState(delegate: self, pid: pid, session: podSession)
    default:
      fatalError("Unsupported state output: \(stateOutput)")
    }
  }

  func makeCancelledState(from state: State) -> State {
    /* Move back to the starting state after a cancellation. This allows us to make sure that the Podz instance is
     * still in the correct state after the previous operations.
     */
    return startingStateFactory.makeState(delegate: self, podz: podz)
  }
}

extension BaseScenario: Scenario {
  final func start() {
    delegate?.scenario(self, moveTo: makeStartState())
  }

  final func stop() {
    delegate?.scenario(self, moveTo: makeStopState())
  }
}

extension BaseScenario: StateDelegate {
  final func move(to transition: StateTransition) {
    delegate?.scenario(self, moveTo: makeState(for: transition))
  }

  final func state(_ state: State, didFailWithError error: Error) {
    delegate?.scenario(self, didFailWithError: error)
  }
}
