//
//  WaitForPodState.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

/* Waits for a pod, and transitions to the wait-for-blip state thereinafter */
final class WaitForPodState {
  weak var delegate: StateDelegate?

  private var isActive = true

  init(delegate: StateDelegate) {
    self.delegate = delegate
  }
}

extension WaitForPodState: State {}

extension WaitForPodState: NewPodObserving {
  func handleNewPod(_ pod: Pod) {
    guard isActive else {
      return
    }
    isActive = false

    delegate?.move(to: .next(from: .waitForPod))
  }
}

extension WaitForPodState: Cancellable {
  func cancel() {
    guard isActive else {
      return
    }
    isActive = false

    Log.debug(.public("Cancelling \(logDescription)..."))
    delegate?.move(to: .cancelled(from: self))
  }
}

extension WaitForPodState: DefaultPodzStatusObservingState {}
