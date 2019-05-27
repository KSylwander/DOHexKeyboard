//
//  DefaultEstablishCloudSessionStateFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-17.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

struct DefaultEstablishCloudSessionStateFactory {
  let establishCloudSessionUseCase: EstablishCloudSessionUseCase
  let retryHandlerFactory: AsyncRetryHandlerFactory
}

extension DefaultEstablishCloudSessionStateFactory: EstablishCloudSessionStateFactory {
  func makeState(delegate: StateDelegate, pid: UInt32, userId: String, podSession: PodSession) -> State {
    return EstablishCloudSessionState(
      delegate: delegate,
      pid: pid,
      userId: userId,
      podSession: podSession,
      establishCloudSessionUseCase: establishCloudSessionUseCase,
      retryHandlerFactory: retryHandlerFactory
    )
  }
}
