//
//  TransferIdState.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

/* Mix-in that allows a transfer ID to be sent to the pod via its session */
protocol TransferIdState: State, Startable {
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
    let transaction = TransferIdViaUSBSerialTransactionBuilder().build(id: transferId)
    transaction.onDone = { [weak self] _, status in
      self?.handleTransactionStatus(status)
    }
    try session.perform(transaction: transaction)
    self.transaction = transaction
  }

  private func handleErrors(in action: () throws -> Void) {
    do {
      try action()
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
        try retryHandler.perform(withMaxRetriesExceededError: AppTerminalError.transferFailed)
        return
      }
      retryHandler.reset()
      try handleTransactionSuccess()
    }
  }
}
