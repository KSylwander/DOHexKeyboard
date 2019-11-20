//
//  DefaultPodzStatusObservingState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

/* Mix-in that handles propagation of Podz errors */
protocol DefaultPodzStatusObservingState: State, PodzStatusObserving {
  var delegate: StateDelegate? { get }
}

extension DefaultPodzStatusObservingState {
  func handleStatus(_ status: PodzStatus, for podz: Podz) {
    switch status {
    case .locked:
      podz.stop()

      if let self = self as? Cancellable {
        self.cancel()
      }
      delegate?.state(self, didFailWithError: ConfigurationError.invalidCredentials)
    case let .pending(error):
      if let self = self as? Cancellable {
        self.cancel()
      }
      delegate?.state(self, didFailWithError: error)
    default:
      if let self = self as? ValidPodzStatusObserving {
        self.handleValidStatus(status, for: podz)
      }
    }
  }
}
