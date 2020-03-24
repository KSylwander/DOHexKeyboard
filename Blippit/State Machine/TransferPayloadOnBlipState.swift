//
//  TransferPayloadOnBlipState.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

final class TransferPayloadOnBlipState {
  weak var delegate: StateDelegate?
  let session: PodSession
  let payload: PodzPayload

  var transaction: Transaction?

  var isCancelling = false

  private let retryHandlerFactory: RetryHandlerFactory
  lazy var retryHandler = retryHandlerFactory.makeRetryHandler { [weak self] in
    try self?.performAction()
  }

  init(delegate: StateDelegate,
       session: PodSession,
       payload: PodzPayload,
       retryHandlerFactory: RetryHandlerFactory) {

    self.delegate = delegate
    self.session = session
    self.payload = payload
    self.retryHandlerFactory = retryHandlerFactory
  }
}

extension TransferPayloadOnBlipState: TransferPayloadState {
  func handleTransactionSuccess() throws {
    try session.close()
    delegate?.move(to: .next(from: .transferPayloadOnBlip))
  }
}

extension TransferPayloadOnBlipState: CancellablePodSessionState {}

extension TransferPayloadOnBlipState: DefaultPodSessionStateObservingState {}

extension TransferPayloadOnBlipState: DefaultPodzStatusObservingState {}
