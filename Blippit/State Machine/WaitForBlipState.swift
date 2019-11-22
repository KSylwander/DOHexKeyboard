//
//  WaitForBlipState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-08.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import PodzKit

/* Waits for a blip to occur */
final class WaitForBlipState {
  weak var delegate: StateDelegate?

  private var isCancelling = false

  init(delegate: StateDelegate) {
    self.delegate = delegate
  }
}

extension WaitForBlipState: State {}

extension WaitForBlipState: PodStateObserving {
  func handleState(_ state: PodState, for pod: Pod) {
    guard case let .blip(session) = state else {
      return
    }
    delegate?.state(self, moveFrom: .waitForBlip(pid: pod.pid, podSession: session))
  }
}

extension WaitForBlipState: Cancellable {
  func cancel() {
    guard !isCancelling else {
      return
    }
    isCancelling = true

    Log.debug(.public("Cancelling \(logDescription)..."))
    delegate?.state(self, moveFrom: .cancelling)
  }
}

extension WaitForBlipState: DefaultPodzStatusObservingState {}
