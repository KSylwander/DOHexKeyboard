//
//  DefaultEstablishCloudSessionStateFactory.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

struct DefaultEstablishCloudSessionStateFactory {
  let serviceInfo: ServiceInfo

  let establishCloudSessionUseCase: EstablishCloudSessionUseCase
  let retryHandlerFactory: AsyncRetryHandlerFactory
}

extension DefaultEstablishCloudSessionStateFactory: EstablishCloudSessionStateFactory {
  func makeState(delegate: StateDelegate, pid: UInt32, podSession: PodSession) -> State {
    return EstablishCloudSessionState(
      delegate: delegate,
      pid: pid,
      serviceInfo: serviceInfo,
      podSession: podSession,
      establishCloudSessionUseCase: establishCloudSessionUseCase,
      retryHandlerFactory: retryHandlerFactory
    )
  }
}
