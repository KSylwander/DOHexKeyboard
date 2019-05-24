//
//  UploadCommandDataState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

/* Uploads a command data to the Blippit SAC */
final class UploadCommandDataState {
  weak var delegate: StateDelegate?
  var isCancelling = false

  private let cloudSessionId: String
  private let data: CommandData

  private let podSession: PodSession

  private var task: Cancellable?

  private let uploadCommandDataUseCase: UploadCommandDataUseCase

  private let retryHandlerFactory: AsyncRetryHandlerFactory
  lazy var retryHandler = retryHandlerFactory.makeRetryHandler { [weak self] in
    self?.performRequest()
  }

  init(delegate: StateDelegate,
       cloudSessionId: String,
       data: CommandData,
       podSession: PodSession,
       uploadCommandDataUseCase: UploadCommandDataUseCase,
       retryHandlerFactory: AsyncRetryHandlerFactory) {

    self.delegate = delegate

    self.cloudSessionId = cloudSessionId
    self.data = data

    self.podSession = podSession

    self.uploadCommandDataUseCase = uploadCommandDataUseCase
    self.retryHandlerFactory = retryHandlerFactory
  }
}

extension UploadCommandDataState: State {}

extension UploadCommandDataState: HttpRequestState {
  func performRequest() {
    guard !isCancelling else {
      return
    }

    task = uploadCommandDataUseCase.uploadCommandData(
      sessionId: cloudSessionId,
      data: data,
      completion: { response, result in
        switch result {
        case let .failure(error):
          self.handleError(error)
        case let .success(dataToken):
          do {
            let dataToken = try TransferId(from: dataToken)
            self.move(
              to: .transferDataToken(
                cloudSessionId: self.cloudSessionId,
                podSession: self.session,
                dataToken: dataToken
              )
            )
          } catch {
            self.handleError(error)
          }
        }
      }
    )
  }

  private func move(to state: RawState) {
    DispatchQueue.main.async {
      self.delegate?.state(self, moveTo: state)
    }
  }
}

extension UploadCommandDataState: CancellationHandler {
  func handleCancellation() {
    task?.cancel()
  }
}

extension UploadCommandDataState: DefaultPodSessionStateObservingState {}

extension UploadCommandDataState: CancellablePodSessionState {
  var session: PodSession {
    return podSession
  }
}

extension UploadCommandDataState: DefaultPodzStatusObservingState {}
