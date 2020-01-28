//
//  TransferPayerIdState.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

final class TransferPayerIdState {
  weak var delegate: StateDelegate?
  let session: PodSession
  let transferId: TransferId

  var transaction: Transaction?

  var isCancelling = false

  private let retryHandlerFactory: RetryHandlerFactory
  lazy var retryHandler = retryHandlerFactory.makeRetryHandler { [weak self] in
    try self?.performAction()
  }

  init(delegate: StateDelegate,
       session: PodSession,
       payerId: TransferId,
       retryHandlerFactory: RetryHandlerFactory) {

    self.delegate = delegate
    self.session = session
    self.transferId = payerId
    self.retryHandlerFactory = retryHandlerFactory
  }
}

extension TransferPayerIdState: BlippitSessionState {}

extension TransferPayerIdState: TransferIdState {
  func handleTransactionSuccess() throws {
    try session.close()
    delegate?.move(to: .next(from: .transferPayerId))
  }
}

extension TransferPayerIdState: CancellablePodSessionState {}

extension TransferPayerIdState: DefaultPodSessionStateObservingState {}

extension TransferPayerIdState: DefaultPodzStatusObservingState {}
