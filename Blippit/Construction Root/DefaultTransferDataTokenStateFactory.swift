//
//  DefaultTransferDataTokenStateFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

struct DefaultTransferDataTokenStateFactory {
  let retryHandlerFactory: RetryHandlerFactory
}

extension DefaultTransferDataTokenStateFactory: TransferDataTokenStateFactory {
  func makeState(delegate: StateDelegate, cloudSessionId: String, session: PodSession, dataToken: TransferId) -> State {
    return TransferDataTokenState(
      delegate: delegate,
      cloudSessionId: cloudSessionId,
      session: session,
      dataToken: dataToken,
      retryHandlerFactory: retryHandlerFactory
    )
  }
}
