//
//  DefaultTransferPayerIdStateFactory.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

struct DefaultTransferPayerIdStateFactory {
  let retryHandlerFactory: RetryHandlerFactory
  let payerId: PodzPayload
}

extension DefaultTransferPayerIdStateFactory: TransferPayerIdStateFactory {
  func makeState(delegate: StateDelegate, session: PodSession) -> State {
    return TransferPayerIdState(
      delegate: delegate,
      session: session,
      payerId: payerId,
      retryHandlerFactory: retryHandlerFactory
    )
  }
}
