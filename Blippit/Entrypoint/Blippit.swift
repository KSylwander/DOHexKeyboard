//
//  Blippit.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

public protocol Blippit {
  func start(userId: String)
  func stop()

  func reset()
}

public extension Blippit {
  var factory: BlippitFactory {
    let decoder = JSONDecoder()
    let urlSession = URLSession(configuration: .default)
    let httpStatusCodeValidator = DefaultHttpStatusCodeValidator()

    return DefaultBlippitFactory(
      startingStateFactory: DefaultStartingStateFactory(),
      startedStateFactory: DefaultStartedStateFactory(),
      establishCloudSessionUseCaseFactory: DefaultEstablishCloudSessionUseCaseFactory(
        requestBuilder: DefaultURLRequestBuilder(apiConfig: Constants.api.establishCloudSession.config),
        encoder: JSONEncoder(),
        decoder: decoder,
        uploadDataUseCase: DefaultUploadDataUseCase(
          uploadTaskFactory: urlSession,
          httpStatusCodeValidator: httpStatusCodeValidator
        )
      ),
      uploadCommandDataUseCase: DefaultUploadCommandDataUseCase(
        requestBuilder: DefaultURLRequestBuilder(apiConfig: Constants.api.uploadCommandData.config),
        decoder: decoder,
        fetchDataUseCase: DefaultFetchDataUseCase(
          dataTaskFactory: urlSession,
          httpStatusCodeValidator: httpStatusCodeValidator
        )
      ),
      retryHandlerFactory: DefaultRetryHandlerFactory(maxRetries: Constants.states.transferDataToken.maxRetries)
    )
  }
}
