//
//  StartingState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

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

extension StartingState: ValidPodzStatusObserving {
  func handleValidStatus(_ status: PodzStatus, for podz: Podz) {
    if status == .idle {
      podz.start()
    } else if status == .running {
      delegate?.state(self, moveFrom: .starting)
    }
  }
}

extension StartingState: DefaultPodzStatusObservingState {}
