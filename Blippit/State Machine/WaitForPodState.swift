//
//  WaitForPodState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-06-17.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

/* Waits for a pod, and transitions to the wait-for-blip state thereinafter */
final class WaitForPodState {
  weak var delegate: StateDelegate?

  private var isCancelling = false

  init(delegate: StateDelegate) {
    self.delegate = delegate
  }
}

extension WaitForPodState: State {}

extension WaitForPodState: NewPodObserving {
  func handleNewPod(_ pod: Pod) {
    delegate?.state(self, moveFrom: .waitForPod)
  }
}

extension WaitForPodState: Cancellable {
  func cancel() {
    guard !isCancelling else {
      return
    }
    isCancelling = true

    Log.debug(.public("Cancelling \(logDescription)..."))
    delegate?.state(self, moveFrom: .cancelling)
  }
}

extension WaitForPodState: DefaultPodzStatusObservingState {}
