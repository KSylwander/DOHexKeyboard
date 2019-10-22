//
//  CancellablePodSessionState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

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

    do {
      try session.close()
    } catch {
      delegate?.state(self, didFailWithError: error)
    }

    if let self = self as? CancellationHandler {
      self.handleCancellation()
    }

    delegate?.state(self, moveFrom: .cancelling)
  }
}
