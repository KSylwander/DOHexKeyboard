//
//  EstablishCloudSessionState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

/* Establishes a session to the Blippit SAC */
final class EstablishCloudSessionState {
  weak var delegate: StateDelegate?
  var isCancelling = false

  private let pid: UInt32
  private let podSession: PodSession
  private let userId: String

  private var task: Cancellable?

  private let establishCloudSessionUseCase: EstablishCloudSessionUseCase

  init(delegate: StateDelegate,
       pid: UInt32,
       userId: String,
       podSession: PodSession,
       establishCloudSessionUseCase: EstablishCloudSessionUseCase) {

    self.delegate = delegate

    self.pid = pid
    self.podSession = podSession
    self.userId = userId

    self.establishCloudSessionUseCase = establishCloudSessionUseCase
  }
}

extension EstablishCloudSessionState: State {}

extension EstablishCloudSessionState: Startable {
  func start() {
    task = establishCloudSessionUseCase.establishCloudSession(pid: pid, userId: userId) { _, result in
      switch result {
      case let .failure(error):
        self.delegate?.state(self, didFailWithError: error)
      case .success:
        // TODO: Transition to the next state
        break
      }
    }
  }
}

extension EstablishCloudSessionState: CancellationHandler {
  func handleCancellation() {
    task?.cancel()
  }
}

extension EstablishCloudSessionState: DefaultPodSessionStateObservingState {}

extension EstablishCloudSessionState: CancellablePodSessionState {
  var session: PodSession {
    return podSession
  }
}

extension EstablishCloudSessionState: DefaultPodzStatusObservingState {}
