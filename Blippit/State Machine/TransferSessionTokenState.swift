//
//  TransferSessionTokenState.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

/* Sends the session token to the pod via its session, then closes the latter */
final class TransferSessionTokenState {
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
       sessionToken: TransferId,
       retryHandlerFactory: RetryHandlerFactory) {

    self.delegate = delegate
    self.cloudSessionId = cloudSessionId
    self.session = session
    self.transferId = sessionToken
    self.retryHandlerFactory = retryHandlerFactory
  }
}

extension TransferSessionTokenState: BlippitSessionState {}

extension TransferSessionTokenState: TransferIdState {
  func handleTransactionSuccess() throws {
    delegate?.move(to: .next(from: .transferSessionToken(cloudSessionId: cloudSessionId, podSession: session)))
  }
}

extension TransferSessionTokenState: CancellablePodSessionState {}

extension TransferSessionTokenState: DefaultPodSessionStateObservingState {}

extension TransferSessionTokenState: DefaultPodzStatusObservingState {}
