//
//  DefaultTransferPayloadOnBlipStateFactory.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

struct DefaultTransferPayloadOnBlipStateFactory {
  let retryHandlerFactory: RetryHandlerFactory
  let payload: PodzPayload
}

extension DefaultTransferPayloadOnBlipStateFactory: TransferPayloadOnBlipStateFactory {
  func makeState(delegate: StateDelegate, session: PodSession) -> State {
    return TransferPayloadOnBlipState(
      delegate: delegate,
      session: session,
      payload: payload,
      retryHandlerFactory: retryHandlerFactory
    )
  }
}
