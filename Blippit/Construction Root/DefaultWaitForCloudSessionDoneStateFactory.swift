//
//  DefaultWaitForCloudSessionDoneStateFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-23.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

struct DefaultWaitForCloudSessionDoneStateFactory {
  let pollInterval: TimeInterval
  let getCloudSessionStatusUseCase: GetCloudSessionStatusUseCase
  let retryHandlerFactory: AsyncRetryHandlerFactory
}

extension DefaultWaitForCloudSessionDoneStateFactory: WaitForCloudSessionDoneStateFactory {
  func makeState(delegate: StateDelegate, cloudSessionId: String) -> State {
    return WaitForCloudSessionDoneState(
      delegate: delegate,
      cloudSessionId: cloudSessionId,
      pollInterval: pollInterval,
      getCloudSessionStatusUseCase: getCloudSessionStatusUseCase,
      retryHandlerFactory: retryHandlerFactory
    )
  }
}
