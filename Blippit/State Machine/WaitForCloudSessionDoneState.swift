//
//  WaitForCloudSessionDoneState.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

/* Waits for the cloud session to be marked as done */
final class WaitForCloudSessionDoneState {
  weak var delegate: StateDelegate?
  var isCancelling = false

  private let cloudSessionId: String
  private var task: Cancellable?
  private let pollInterval: TimeInterval

  private let podSession: PodSession

  private let getCloudSessionStatusUseCase: GetCloudSessionStatusUseCase

  private let retryHandlerFactory: AsyncRetryHandlerFactory
  lazy var retryHandler = retryHandlerFactory.makeRetryHandler { [weak self] in
    self?.performRequest()
  }

  init(delegate: StateDelegate,
       cloudSessionId: String,
       pollInterval: TimeInterval,
       podSession: PodSession,
       getCloudSessionStatusUseCase: GetCloudSessionStatusUseCase,
       retryHandlerFactory: AsyncRetryHandlerFactory) {

    self.delegate = delegate

    self.cloudSessionId = cloudSessionId
    self.pollInterval = pollInterval

    self.podSession = podSession

    self.getCloudSessionStatusUseCase = getCloudSessionStatusUseCase
    self.retryHandlerFactory = retryHandlerFactory
  }
}

extension WaitForCloudSessionDoneState: State {}

extension WaitForCloudSessionDoneState: BlippitSessionState {}

extension WaitForCloudSessionDoneState: HttpRequestState {
  func performRequest() {
    guard !isCancelling else {
      return
    }

    task = getCloudSessionStatusUseCase.getCloudSessionStatus(sessionId: cloudSessionId) { _, result in
      switch result {
      case let .failure(error):
        self.handleError(error)
      case let .success(status):
        switch status {
        case .established, .notStarted:
          self.scheduleNextPoll()
        case .done:
          do {
            try self.podSession.close()
            self.move(to: .next(from: .waitForCloudSessionDone))
          } catch {
            self.handleError(error)
          }
        }
      }
    }
  }

  private func scheduleNextPoll() {
    DispatchQueue.main.asyncAfter(
      deadline: .now() + .milliseconds(Int(self.pollInterval * 1000.0)),
      execute: performRequest
    )
  }

  private func move(to transition: StateTransition) {
    DispatchQueue.main.async {
      self.delegate?.move(to: transition)
    }
  }
}

extension WaitForCloudSessionDoneState: CancellationHandler {
  func handleCancellation() {
    task?.cancel()
  }
}

extension WaitForCloudSessionDoneState: DefaultPodSessionStateObservingState {}

extension WaitForCloudSessionDoneState: CancellablePodSessionState {
  var session: PodSession {
    return podSession
  }
}

extension WaitForCloudSessionDoneState: DefaultPodzStatusObservingState {}
