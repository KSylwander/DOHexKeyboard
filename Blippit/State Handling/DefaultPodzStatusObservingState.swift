//
//  DefaultPodzStatusObservingState.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

/* Mix-in that handles propagation of Podz errors */
protocol DefaultPodzStatusObservingState: State, PodzStatusObserving, Cancellable {
  var delegate: StateDelegate? { get }
}

extension DefaultPodzStatusObservingState {
  func handleStatus(_ status: PodzStatus, for podz: Podz) {
    switch status {
    case .pending:
      /* Allow the next state (e.g., `StartingState`) to handle the failure */
      cancel()
    default:
      /* Do nothing */
      break
    }
  }
}
