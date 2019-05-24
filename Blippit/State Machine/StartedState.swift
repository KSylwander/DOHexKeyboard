//
//  StartedState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-08.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import os.log
import Podz

/* Waits for a blip to occur, and handles opening of the session thereinafter */
final class StartedState {
  weak var delegate: StateDelegate?

  private var isCancelling = false

  init(delegate: StateDelegate) {
    self.delegate = delegate
  }
}

extension StartedState: State {}

extension StartedState: PodStateObserving {
  func handleState(_ state: PodState, for pod: Pod) {
    guard case let .blip(session) = state else {
      return
    }

    do {
      try session.open()
      // TODO: Transition to the next state
    } catch {
      delegate?.state(self, didFailWithError: error)
    }
  }
}

extension StartedState: Cancellable {
  func cancel() {
    guard !isCancelling else {
      return
    }
    isCancelling = true

    os_log(
      "%{public}@ %{public}@:%{public}d -> Cancelling %{public}@...",
      log: Constants.log,
      type: .debug,
      "[DEBUG]", #function, #line,
      String(describing: type(of: self))
    )
    delegate?.state(self, moveTo: .starting)
  }
}

extension StartedState: DefaultPodzStatusObservingState {}
