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
  private let data: String

  private let podSession: PodSession

  private var task: Cancellable?

  private let uploadCommandDataUseCase: UploadCommandDataUseCase

  init(delegate: StateDelegate,
       cloudSessionId: String,
       data: String,
       podSession: PodSession,
       uploadCommandDataUseCase: UploadCommandDataUseCase) {

    self.delegate = delegate

    self.cloudSessionId = cloudSessionId
    self.data = data

    self.podSession = podSession

    self.uploadCommandDataUseCase = uploadCommandDataUseCase
  }
}

extension UploadCommandDataState: State {}

extension UploadCommandDataState: Startable {
  func start() {
    task = uploadCommandDataUseCase.uploadCommandData(
      sessionId: cloudSessionId,
      data: data,
      completion: { response, result in
        switch result {
        case let .failure(error):
          self.delegate?.state(self, didFailWithError: error)
        case let .success(dataToken):
          do {
            let dataToken = try TransferId(from: dataToken)
            self.delegate?.state(self, moveTo: .transferDataToken(podSession: self.session, dataToken: dataToken))
          } catch {
            self.delegate?.state(self, didFailWithError: error)
          }
        }
      }
    )
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
