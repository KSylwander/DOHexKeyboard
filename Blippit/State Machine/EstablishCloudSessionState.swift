//
//  EstablishCloudSessionState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import PodzKit

/* Establishes a session to the Blippit SAC */
final class EstablishCloudSessionState {
  weak var delegate: StateDelegate?
  var isCancelling = false

  private let pid: UInt32
  private let podSession: PodSession
  private let serviceInfo: ServiceInfo

  private var task: Cancellable?

  private let establishCloudSessionUseCase: EstablishCloudSessionUseCase

  private let retryHandlerFactory: AsyncRetryHandlerFactory
  lazy var retryHandler = retryHandlerFactory.makeRetryHandler { [weak self] in
    self?.performRequest()
  }

  init(delegate: StateDelegate,
       pid: UInt32,
       serviceInfo: ServiceInfo,
       podSession: PodSession,
       establishCloudSessionUseCase: EstablishCloudSessionUseCase,
       retryHandlerFactory: AsyncRetryHandlerFactory) {

    self.delegate = delegate

    self.pid = pid
    self.podSession = podSession
    self.serviceInfo = serviceInfo

    self.establishCloudSessionUseCase = establishCloudSessionUseCase
    self.retryHandlerFactory = retryHandlerFactory
  }
}

extension EstablishCloudSessionState: State {}

extension EstablishCloudSessionState: BlippitSessionState {}

extension EstablishCloudSessionState: HttpRequestState {
  func performRequest() {
    guard !isCancelling else {
      return
    }

    task = establishCloudSessionUseCase.establishCloudSession(pid: pid, serviceInfo: serviceInfo) { _, result in
      switch result {
      case let .failure(error):
        self.handleError(error)
      case let .success(response):
        do {
          let sessionToken = try TransferId(from: "\(Constants.sessionTokenPrefix)\(response.sessionToken)")
          self.move(
            to: .next(
              from: .establishCloudSession(
                cloudSessionId: response.sessionId,
                podSession: self.podSession,
                sessionToken: sessionToken
              )
            )
          )
        } catch {
          self.handleError(error)
        }
      }
    }
  }

  private func move(to transition: StateTransition) {
    DispatchQueue.main.async {
      self.delegate?.move(to: transition)
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
