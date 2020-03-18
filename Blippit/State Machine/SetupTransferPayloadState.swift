//
//  SetupTransferPayloadState.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

/* Opens the pod session, waits for it to be opened, then checks if transferring of payloads is supported */
final class SetupTransferPayloadState {
  weak var delegate: StateDelegate?
  let session: PodSession
  var isCancelling = false

  private let pid: UInt32

  init(delegate: StateDelegate, pid: UInt32, session: PodSession) {
    self.delegate = delegate
    self.session = session
    self.pid = pid
  }
}

extension SetupTransferPayloadState: Startable {
  func start() {
    do {
      try session.open()
    } catch {
      delegate?.state(self, didFailWithError: error)
    }
  }
}

extension SetupTransferPayloadState: ValidPodSessionStateObserving {
  func handleValidState(_ state: PodSessionState, for session: PodSession) {
    do {
      guard state == .open else {
        return
      }

      guard try session.availableTransactions().contains(.payloadAsUSBSerial) else {
        /* Allow clients to handle blipping on pods that do not support transferring of payloads */
        throw InternalAppTerminalError.unsupported
      }

      delegate?.move(to: .next(from: .setupTransferPayload(pid: pid, podSession: session)))
    } catch {
      cancel()
      delegate?.state(self, didFailWithError: error)
    }
  }
}

extension SetupTransferPayloadState: DefaultPodSessionStateObservingState {}

extension SetupTransferPayloadState: CancellablePodSessionState {}

extension SetupTransferPayloadState: DefaultPodzStatusObservingState {}
