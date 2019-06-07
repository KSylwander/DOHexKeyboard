//
//  TransferCloudSessionDoneTokenState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-06-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

/* Sends the cloud session done token to the pod via its session, then closes the latter */
final class TransferCloudSessionDoneTokenState {
  static let transactionFailedError: Error = BlippitError.transferCloudSessionDoneTokenFailed

  weak var delegate: StateDelegate?
  let session: PodSession
  let transferId: TransferId

  var transaction: Transaction?

  var isCancelling = false

  private let retryHandlerFactory: RetryHandlerFactory
  lazy var retryHandler = retryHandlerFactory.makeRetryHandler { [weak self] in
    try self?.performAction()
  }

  init(delegate: StateDelegate, session: PodSession, doneToken: TransferId, retryHandlerFactory: RetryHandlerFactory) {
    self.delegate = delegate
    self.session = session
    self.transferId = doneToken
    self.retryHandlerFactory = retryHandlerFactory
  }
}

extension TransferCloudSessionDoneTokenState: BlippitSessionState {}

extension TransferCloudSessionDoneTokenState: TransferIdState {
  func handleTransactionSuccess() throws {
    try session.close()
    delegate?.state(self, moveTo: .blippitSessionCompleted)
  }
}

extension TransferCloudSessionDoneTokenState: CancellablePodSessionState {}

extension TransferCloudSessionDoneTokenState: DefaultPodSessionStateObservingState {}

extension TransferCloudSessionDoneTokenState: DefaultPodzStatusObservingState {}
