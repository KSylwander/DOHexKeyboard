//
//  WaitForCloudSessionDoneState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-23.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

/* Waits for the cloud session to be marked as done */
final class WaitForCloudSessionDoneState {
  weak var delegate: StateDelegate?
  var isCancelling = false

  private let cloudSessionId: String
  private var task: Cancellable?
  private let pollInterval: TimeInterval

  private let getCloudSessionStatusUseCase: GetCloudSessionStatusUseCase

  private let retryHandlerFactory: AsyncRetryHandlerFactory
  lazy var retryHandler = retryHandlerFactory.makeRetryHandler { [weak self] in
    self?.performRequest()
  }

  init(delegate: StateDelegate,
       cloudSessionId: String,
       pollInterval: TimeInterval,
       getCloudSessionStatusUseCase: GetCloudSessionStatusUseCase,
       retryHandlerFactory: AsyncRetryHandlerFactory) {

    self.delegate = delegate

    self.cloudSessionId = cloudSessionId
    self.pollInterval = pollInterval

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

    task = getCloudSessionStatusUseCase.getCloudSessionStatus(sessionId: cloudSessionId) { response, result in
      switch result {
      case let .failure(error):
        self.handleError(error)
      case let .success(status):
        switch status {
        case .established, .notStarted:
          self.scheduleNextPoll()
        case .done:
          self.move(to: .blippitSessionCompleted)
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

  private func move(to state: RawState) {
    DispatchQueue.main.async {
      self.delegate?.state(self, moveTo: state)
    }
  }
}

extension WaitForCloudSessionDoneState: Cancellable {
  func cancel() {
    guard !isCancelling else {
      return
    }
    isCancelling = true

    Log.debug(.public("Cancelling \(logDescription)..."))
    task?.cancel()

    /* Move back to the starting state after a cancellation. This allows us to make sure that the Podz is still in the
     * correct state after the previous operations.
     */
    delegate?.state(self, moveTo: .starting)
  }
}

extension WaitForCloudSessionDoneState: DefaultPodzStatusObservingState {}
