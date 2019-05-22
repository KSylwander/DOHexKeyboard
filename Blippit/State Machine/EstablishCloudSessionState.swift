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
  private lazy var retryHandler = retryHandlerFactory.makeRetryHandler { [weak self] in
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

extension EstablishCloudSessionState: Startable {
  func start() {
    performRequest()
  }

  private func performRequest() {
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

  private func handleError(_ error: Error) {
    DispatchQueue.main.async {
      self.handleErrors {
        switch error {
        case let error as URLError where error.code == .cancelled:
          return
        case is URLError, BlippitError.invalidHttpStatusCode:
          /* Retry URL and HTTP status errors */
          self.retryHandler.perform(withMaxRetriesExceededError: error, onError: self.handleError(_:))
        default:
          /* Propagate all other errors */
          throw error
        }
      }
    }
  }

  private func handleErrors(in action: () throws -> Void) {
    do {
      try action()
    } catch {
      cancel()
      self.delegate?.state(self, didFailWithError: error)
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
