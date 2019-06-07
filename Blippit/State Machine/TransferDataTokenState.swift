//
//  TransferDataTokenState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

/* Sends the data token to the pod via its session, then closes the latter */
final class TransferDataTokenState {
  static let transactionFailedError: Error = BlippitError.transferDataTokenFailed

  weak var delegate: StateDelegate?
  let cloudSessionId: String
  let session: PodSession
  let transferId: TransferId

  var transaction: Transaction?

  var isCancelling = false

  private let retryHandlerFactory: RetryHandlerFactory
  lazy var retryHandler = retryHandlerFactory.makeRetryHandler { [weak self] in
    try self?.performAction()
  }

  init(delegate: StateDelegate,
       cloudSessionId: String,
       session: PodSession,
       dataToken: TransferId,
       retryHandlerFactory: RetryHandlerFactory) {

    self.delegate = delegate
    self.cloudSessionId = cloudSessionId
    self.session = session
    self.transferId = dataToken
    self.retryHandlerFactory = retryHandlerFactory
  }
}

extension TransferDataTokenState: BlippitSessionState {}

extension TransferDataTokenState: TransferIdState {
  func handleTransactionSuccess() throws {
    try session.close()
    delegate?.state(self, moveTo: .waitForCloudSessionDone(cloudSessionId: cloudSessionId))
  }
}

extension TransferDataTokenState: CancellablePodSessionState {}

extension TransferDataTokenState: DefaultPodSessionStateObservingState {}

extension TransferDataTokenState: DefaultPodzStatusObservingState {}
