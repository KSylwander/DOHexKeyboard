//
//  BlippitSetup.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-24.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

public enum BlippitSetup {
  public static func setup(delegate: BlippitDelegate, configuration: BlippitConfiguration) throws -> Blippit {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    let policyHandler = SecPolicyHandler()
    let trustHandler = SecTrustHandler()
    let certificateHandler = SecCertificateHandler()

    let pinnedCertificates: [Certificate] = try {
      let bundle = Bundle(for: DefaultBlippit.self)
      let urls = bundle.urls(forResourcesWithExtension: "crt", subdirectory: nil)
      let certificateFactory = DefaultCertificateFactory(certificateHandler: certificateHandler)
      return try (urls ?? []).map(certificateFactory.makeCertificate(url:))
    }()

    let authenticationManager = SACAuthenticationManager(
      certificatePinning: CertificatePinningManager(
        pinnedCertificates: pinnedCertificates,
        applyCertificatePinningUseCaseFactory: DefaultApplyCertificatePinningUseCaseFactory(
          policyHandler: policyHandler,
          trustHandler: trustHandler
        ),
        validateTrustUseCase: DefaultValidateTrustUseCase(trustHandler: trustHandler),
        validateTrustedCertificatesUseCase: DefaultValidateTrustedCertificatesUseCase(
          trustHandler: trustHandler,
          certificateHandler: certificateHandler
        )
      )
    )

    let urlSession = URLSession(configuration: .default, retainedDelegate: authenticationManager)
    let httpStatusCodeValidator = DefaultHttpStatusCodeValidator()

    return DefaultBlippit(
      delegate: delegate,
      podz: try PodzSetup.setup(appId: configuration.podzAppId, apiKey: configuration.podzApiKey),
      startingStateFactory: DefaultStartingStateFactory(),
      startedStateFactory: DefaultStartedStateFactory(),
      setupTransferIdStateFactory: DefaultSetupTransferIdStateFactory(),
      establishCloudSessionStateFactory: DefaultEstablishCloudSessionStateFactory(
        establishCloudSessionUseCase: DefaultEstablishCloudSessionUseCase(
          appId: configuration.blippitAppId,
          requestBuilder: DefaultURLRequestBuilder(
            apiConfig: Constants.api.establishCloudSession.config,
            apiKey: configuration.blippitApiKey
          ),
          encoder: encoder,
          decoder: decoder,
          uploadDataUseCase: DefaultUploadDataUseCase(
            uploadTaskFactory: urlSession,
            httpStatusCodeValidator: httpStatusCodeValidator
          )
        ),
        retryHandlerFactory: DefaultAsyncRetryHandlerFactory(
          maxRetries: Constants.states.establishCloudSession.maxRetries,
          retryInterval: Constants.states.establishCloudSession.retryInterval
        )
      ),
      uploadCommandDataStateFactory: DefaultUploadCommandDataStateFactory(
        uploadCommandDataUseCase: DefaultUploadCommandDataUseCase(
          requestBuilder: DefaultURLRequestBuilder(
            apiConfig: Constants.api.uploadCommandData.config,
            apiKey: configuration.blippitApiKey
          ),
          encoder: encoder,
          decoder: decoder,
          uploadDataUseCase: DefaultUploadDataUseCase(
            uploadTaskFactory: urlSession,
            httpStatusCodeValidator: httpStatusCodeValidator
          )
        ),
        retryHandlerFactory: DefaultAsyncRetryHandlerFactory(
          maxRetries: Constants.states.uploadCommandData.maxRetries,
          retryInterval: Constants.states.uploadCommandData.retryInterval
        )
      ),
      transferDataTokenStateFactory: DefaultTransferDataTokenStateFactory(
        retryHandlerFactory: DefaultRetryHandlerFactory(maxRetries: Constants.states.transferDataToken.maxRetries)
      ),
      waitForCloudSessionDoneStateFactory: DefaultWaitForCloudSessionDoneStateFactory(
        pollInterval: Constants.states.waitForCloudSessionDone.pollInterval,
        getCloudSessionStatusUseCase: DefaultGetCloudSessionStatusUseCase(
          requestBuilder: DefaultURLRequestBuilder(
            apiConfig: Constants.api.getCloudSessionStatus.config,
            apiKey: configuration.blippitApiKey
          ),
          decoder: decoder,
          fetchDataUseCase: DefaultFetchDataUseCase(
            dataTaskFactory: urlSession,
            httpStatusCodeValidator: httpStatusCodeValidator
          )
        ),
        retryHandlerFactory: DefaultAsyncRetryHandlerFactory(
          maxRetries: Constants.states.waitForCloudSessionDone.maxRetries,
          retryInterval: Constants.states.waitForCloudSessionDone.retryInterval
        )
      )
    )
  }
}
