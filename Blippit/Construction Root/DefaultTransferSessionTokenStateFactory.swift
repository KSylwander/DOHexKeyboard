//
//  DefaultTransferSessionTokenStateFactory.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

struct DefaultTransferSessionTokenStateFactory {
  let retryHandlerFactory: RetryHandlerFactory
}

extension DefaultTransferSessionTokenStateFactory: TransferSessionTokenStateFactory {
  func makeState(delegate: StateDelegate,
                 cloudSessionId: String,
                 session: PodSession,
                 sessionToken: TransferId) -> State {

    return TransferSessionTokenState(
      delegate: delegate,
      cloudSessionId: cloudSessionId,
      session: session,
      sessionToken: sessionToken,
      retryHandlerFactory: retryHandlerFactory
    )
  }
}
