//
//  DefaultTransferPayerIdStateFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-10-17.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import PodzKit

struct DefaultTransferPayerIdStateFactory {
  let retryHandlerFactory: RetryHandlerFactory
  let payerId: TransferId
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
