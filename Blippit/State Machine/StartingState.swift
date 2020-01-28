//
//  StartingState.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

/* Starts Podz and waits for it to run */
final class StartingState {
  weak var delegate: StateDelegate?

  private let podz: Podz

  init(delegate: StateDelegate, podz: Podz) {
    self.delegate = delegate
    self.podz = podz
  }
}

extension StartingState: State {}

extension StartingState: Startable {
  func start() {
    handleStatus(podz.status, for: podz)
  }
}

extension StartingState: PodzStatusObserving {
  func handleStatus(_ status: PodzStatus, for podz: Podz) {
    switch status {
    case .idle:
      podz.start()
    case let .pending(error):
      delegate?.state(self, didFailWithError: error)
    case .running:
      delegate?.move(to: .next(from: .starting))
    @unknown default:
      fatalError()
    }
  }
}
