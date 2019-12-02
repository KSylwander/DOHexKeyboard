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

  private var managedPods = [UInt32: Pod]()

  init(delegate: StateDelegate) {
    self.delegate = delegate
  }
}

extension WaitForBlipState: State {}

extension WaitForBlipState: NewPodObserving {
  func handleNewPod(_ pod: Pod) {
    managedPods[pod.pid] = pod
  }
}

extension WaitForBlipState: LostPodObserving {
  func handleLostPod(_ pod: Pod) {
    managedPods.removeValue(forKey: pod.pid)

    /* Go back to previous state when there are no more pods in the vicinity */
    if managedPods.isEmpty {
      delegate?.move(to: .previous(from: self))
    }
  }
}

extension WaitForBlipState: PodStateObserving {
  func handleState(_ state: PodState, for pod: Pod) {
    guard case let .blip(session) = state else {
      return
    }
    delegate?.move(to: .next(from: .waitForBlip(pid: pod.pid, podSession: session)))
  }
}

extension WaitForBlipState: Cancellable {
  func cancel() {
    guard !isCancelling else {
      return
    }
    isCancelling = true

    Log.debug(.public("Cancelling \(logDescription)..."))
    delegate?.move(to: .cancelled(from: self))
  }
}

extension WaitForBlipState: DefaultPodzStatusObservingState {}
