//
//  TransferIdState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

/* Mix-in that allows a transfer ID to be sent to the pod via its session */
protocol TransferIdState: State, Startable {
  static var transactionFailedError: Error { get }

  var delegate: StateDelegate? { get }
  var session: PodSession { get }
  var transferId: TransferId { get }

  var transaction: Transaction? { get set }

  var retryHandler: RetryHandling { get }

  func handleTransactionSuccess() throws
}

extension TransferIdState {
  func start() {
    handleErrors(in: performAction)
  }

  func performAction() throws {
    let transaction = TransferIdsTransactionBuilder().ids(ids: [transferId]).build()!
    transaction.onDone = { [weak self] _, status in
      self?.handleTransactionStatus(status)
    }
    try session.perform(transaction: transaction)
    self.transaction = transaction
  }

  private func handleErrors(in action: () throws -> Void) {
    do {
      do {
        try action()
      } catch PodSessionError.invalidState {
        throw BlippitError.invalidPodSessionState(session.state)
      }
    } catch {
      if let self = self as? Cancellable {
        self.cancel()
      }
      delegate?.state(self, didFailWithError: error)
    }
  }

  private func handleTransactionStatus(_ status: TransactionStatus) {
    handleErrors {
      guard status == .success else {
        try retryHandler.perform(withMaxRetriesExceededError: Self.transactionFailedError)
        return
      }
      retryHandler.reset()
      try handleTransactionSuccess()
    }
  }
}
