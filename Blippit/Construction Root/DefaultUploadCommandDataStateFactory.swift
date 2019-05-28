//
//  DefaultUploadCommandDataStateFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

struct DefaultUploadCommandDataStateFactory {
  let uploadCommandDataUseCase: UploadCommandDataUseCase
  let retryHandlerFactory: AsyncRetryHandlerFactory
}

extension DefaultUploadCommandDataStateFactory: UploadCommandDataStateFactory {
  func makeState(delegate: StateDelegate, cloudSessionId: String, data: CommandData, podSession: PodSession) -> State {
    return UploadCommandDataState(
      delegate: delegate,
      cloudSessionId: cloudSessionId,
      data: data,
      podSession: podSession,
      uploadCommandDataUseCase: uploadCommandDataUseCase,
      retryHandlerFactory: retryHandlerFactory
    )
  }
}
