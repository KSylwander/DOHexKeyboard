//
//  DefaultTransferCloudSessionDoneTokenStateFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-06-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

struct DefaultTransferCloudSessionDoneTokenStateFactory {
  let retryHandlerFactory: RetryHandlerFactory
}

extension DefaultTransferCloudSessionDoneTokenStateFactory: TransferCloudSessionDoneTokenStateFactory {
  func makeState(delegate: StateDelegate, session: PodSession, doneToken: TransferId) -> State {
    return TransferCloudSessionDoneTokenState(
      delegate: delegate,
      session: session,
      doneToken: doneToken,
      retryHandlerFactory: retryHandlerFactory
    )
  }
}
