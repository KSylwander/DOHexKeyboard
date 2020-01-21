//
//  DefaultPodzStatusObservingState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
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
