//
//  DefaultWaitForCloudSessionDoneStateMetaFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-23.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct DefaultWaitForCloudSessionDoneStateMetaFactory {
  let pollInterval: TimeInterval
  let getCloudSessionStatusUseCaseFactory: GetCloudSessionStatusUseCaseFactory
  let retryHandlerFactory: AsyncRetryHandlerFactory
}

extension DefaultWaitForCloudSessionDoneStateMetaFactory: WaitForCloudSessionDoneStateMetaFactory {
  func makeFactory(apiKey: UUID) -> WaitForCloudSessionDoneStateFactory {
    return DefaultWaitForCloudSessionDoneStateFactory(
      pollInterval: pollInterval,
      getCloudSessionStatusUseCase: getCloudSessionStatusUseCaseFactory.makeUseCase(apiKey: apiKey),
      retryHandlerFactory: retryHandlerFactory
    )
  }
}
