//
//  CancellablePodSessionState.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

/* Mix-in that supports cancelling of a pod session-based state */
protocol CancellablePodSessionState: State, Cancellable {
  var delegate: StateDelegate? { get }
  var session: PodSession { get }
  var isCancelling: Bool { get set }
}

extension CancellablePodSessionState {
  func cancel() {
    guard !isCancelling else {
      return
    }
    isCancelling = true

    Log.debug(.public("Cancelling \(logDescription)..."))

    closeSession: do {
      if case .closed = session.state {
        break closeSession
      }
      try session.close()
    } catch {
      delegate?.state(self, didFailWithError: error)
    }

    if let self = self as? CancellationHandler {
      self.handleCancellation()
    }

    delegate?.move(to: .cancelled(from: self))
  }
}
