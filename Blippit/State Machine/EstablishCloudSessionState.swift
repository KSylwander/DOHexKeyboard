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

  private let retryHandlerFactory: AsyncRetryHandlerFactory
  lazy var retryHandler = retryHandlerFactory.makeRetryHandler { [weak self] in
    self?.performRequest()
  }

  init(delegate: StateDelegate,
       pid: UInt32,
       userId: String,
       podSession: PodSession,
       establishCloudSessionUseCase: EstablishCloudSessionUseCase,
       retryHandlerFactory: AsyncRetryHandlerFactory) {

    self.delegate = delegate

    self.pid = pid
    self.podSession = podSession
    self.userId = userId

    self.establishCloudSessionUseCase = establishCloudSessionUseCase
    self.retryHandlerFactory = retryHandlerFactory
  }
}

extension EstablishCloudSessionState: State {}

extension EstablishCloudSessionState: HttpRequestState {
  func performRequest() {
    guard !isCancelling else {
      return
    }

    task = establishCloudSessionUseCase.establishCloudSession(pid: pid, userId: userId) { _, result in
      switch result {
      case let .failure(error):
        self.handleError(error)
      case let .success(sessionId):
        self.move(to: .uploadCommandData(cloudSessionId: sessionId, podSession: self.podSession))
      }
    }
  }

  private func move(to state: RawState) {
    DispatchQueue.main.async {
      self.delegate?.state(self, moveTo: state)
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
