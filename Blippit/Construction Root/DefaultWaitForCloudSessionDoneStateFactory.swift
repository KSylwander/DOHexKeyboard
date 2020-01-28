//
//  DefaultWaitForCloudSessionDoneStateFactory.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

struct DefaultWaitForCloudSessionDoneStateFactory {
  let pollInterval: TimeInterval
  let getCloudSessionStatusUseCase: GetCloudSessionStatusUseCase
  let retryHandlerFactory: AsyncRetryHandlerFactory
}

extension DefaultWaitForCloudSessionDoneStateFactory: WaitForCloudSessionDoneStateFactory {
  func makeState(delegate: StateDelegate, cloudSessionId: String, podSession: PodSession) -> State {
    return WaitForCloudSessionDoneState(
      delegate: delegate,
      cloudSessionId: cloudSessionId,
      pollInterval: pollInterval,
      podSession: podSession,
      getCloudSessionStatusUseCase: getCloudSessionStatusUseCase,
      retryHandlerFactory: retryHandlerFactory
    )
  }
}
