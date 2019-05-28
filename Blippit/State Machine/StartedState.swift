//
//  StartedState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-08.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

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
      delegate?.state(self, moveTo: .setupTransferId(pid: pod.pid, podSession: session))
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

    Log.debug(.public("Cancelling \(logDescription)..."))
    delegate?.state(self, moveTo: .starting)
  }
}

extension StartedState: DefaultPodzStatusObservingState {}
