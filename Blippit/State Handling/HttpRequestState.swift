//
//  HttpRequestState.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol HttpRequestState: State, Startable, Cancellable {
  var delegate: StateDelegate? { get }
  var retryHandler: AsyncRetryHandling { get }

  func performRequest()
}

extension HttpRequestState {
  func start() {
    performRequest()
  }

  func handleError(_ error: Error) {
    DispatchQueue.main.async {
      self.handleErrors {
        switch error {
        case let error as URLError where error.code == .cancelled:
          return
        case is URLError, NetworkError.invalidHttpStatusCode:
          /* Retry URL and HTTP status errors */
          self.retryHandler.perform(withMaxRetriesExceededError: error, onError: self.handleRetryFailure(_:))
        default:
          /* Propagate all other errors */
          throw error
        }
      }
    }
  }

  private func handleRetryFailure(_ error: Error) {
    handleErrors {
      throw error
    }
  }

  private func handleErrors(in action: () throws -> Void) {
    do {
      try action()
    } catch {
      cancel()
      delegate?.state(self, didFailWithError: error)
    }
  }
}
