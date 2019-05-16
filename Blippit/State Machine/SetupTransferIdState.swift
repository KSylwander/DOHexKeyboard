//
//  SetupTransferIdState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

/* Waits for the pod session to be opened, then checks if transferring of IDs is supported */
final class SetupTransferIdState {
  weak var delegate: StateDelegate?
  let session: PodSession
  var isCancelling = false

  init(delegate: StateDelegate, session: PodSession) {
    self.delegate = delegate
    self.session = session
  }
}

extension SetupTransferIdState: ValidPodSessionStateObserving {
  func handleValidState(_ state: PodSessionState, for session: PodSession) {
    do {
      guard state == .open else {
        return
      }

      guard try session.availableTransactions().contains(.transferIds) else {
        /* Allow clients to handle blipping on pods that do not support transferring of IDs */
        throw BlippitError.podDoesNotTransferId
      }

      // TODO: Transition to the next state
    } catch {
      cancel()
      delegate?.state(self, didFailWithError: error)
    }
  }
}

extension SetupTransferIdState: DefaultPodSessionStateObservingState {}

extension SetupTransferIdState: CancellablePodSessionState {}

extension SetupTransferIdState: DefaultPodzStatusObservingState {}
