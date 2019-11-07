//
//  WaitForPodState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-06-17.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import PodzKit

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
    delegate?.move(to: .next(from: .waitForPod))
  }
}

extension WaitForPodState: Cancellable {
  func cancel() {
    guard !isCancelling else {
      return
    }
    isCancelling = true

    Log.debug(.public("Cancelling \(logDescription)..."))
    delegate?.move(to: .next(from: .cancelling))
  }
}

extension WaitForPodState: DefaultPodzStatusObservingState {}
