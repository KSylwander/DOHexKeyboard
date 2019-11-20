//
//  BlippitSetup.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-24.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

/**
 * Main entrypoint where instances of the Blippit SDK can be created.
 */
public enum BlippitSetup {
  /**
   * Builds an instance of the Blippit SDK.
   *
   * The behaviour of multiple `Blippit` instances created from this method is undefined.
   */
  public static func setup(delegate: BlippitDelegate, configuration: BlippitConfiguration) throws -> Blippit {
    let errorHandler = ErrorHandler()
    return try errorHandler.handleErrors {
      return try setup(delegate: delegate, configuration: configuration, errorHandler: errorHandler)
    }
  }

  private static func setup(delegate: BlippitDelegate,
                            configuration: BlippitConfiguration,
                            errorHandler: ErrorHandling) throws -> Blippit {

    let podz = try PodzSetup.setup(
      appId: Constants.credentials.podz.appId,
      apiKey: Constants.credentials.podz.apiKey
    )

    let scenarioFactory: ScenarioFactory = try {
      switch _BlippitMode(configuration.mode) {
      case let .payment(apiKey, appId, serviceInfo):
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
        let responseValidator = DefaultHttpUrlResponseValidator()

        return PaymentScenarioFactory(
          podz: podz,
          startingStateFactory: DefaultStartingStateFactory(),
          waitForPodStateFactory: DefaultWaitForPodStateFactory(),
          waitForBlipStateFactory: DefaultWaitForBlipStateFactory(),
          setupTransferIdStateFactory: DefaultSetupTransferIdStateFactory(),
          establishCloudSessionStateFactory: DefaultEstablishCloudSessionStateFactory(
            serviceInfo: serviceInfo,
            establishCloudSessionUseCase: DefaultEstablishCloudSessionUseCase(
              appId: appId,
              requestBuilder: DefaultURLRequestBuilder(
                apiConfig: Constants.api.establishCloudSession.config,
                apiKey: apiKey
              ),
              encoder: encoder,
              decoder: decoder,
              uploadDataUseCase: DefaultUploadDataUseCase(
                uploadTaskFactory: urlSession,
                responseValidator: responseValidator
              )
            ),
            retryHandlerFactory: DefaultAsyncRetryHandlerFactory(
              maxRetries: Constants.states.establishCloudSession.maxRetries,
              retryInterval: Constants.states.establishCloudSession.retryInterval
            )
          ),
          transferSessionTokenStateFactory: DefaultTransferSessionTokenStateFactory(
            retryHandlerFactory: DefaultRetryHandlerFactory(
              maxRetries: Constants.states.transferSessionToken.maxRetries
            )
          ),
          waitForCloudSessionDoneStateFactory: DefaultWaitForCloudSessionDoneStateFactory(
            pollInterval: Constants.states.waitForCloudSessionDone.pollInterval,
            getCloudSessionStatusUseCase: DefaultGetCloudSessionStatusUseCase(
              requestBuilder: DefaultURLRequestBuilder(
                apiConfig: Constants.api.getCloudSessionStatus.config,
                apiKey: apiKey
              ),
              decoder: decoder,
              fetchDataUseCase: DefaultFetchDataUseCase(
                dataTaskFactory: urlSession,
                responseValidator: responseValidator
              )
            ),
            retryHandlerFactory: DefaultAsyncRetryHandlerFactory(
              maxRetries: Constants.states.waitForCloudSessionDone.maxRetries,
              retryInterval: Constants.states.waitForCloudSessionDone.retryInterval
            )
          )
        )
      case let .payerId(value):
        return PayerIdScenarioFactory(
          podz: podz,
          startingStateFactory: DefaultStartingStateFactory(),
          waitForPodStateFactory: DefaultWaitForPodStateFactory(),
          waitForBlipStateFactory: DefaultWaitForBlipStateFactory(),
          setupTransferIdStateFactory: DefaultSetupTransferIdStateFactory(),
          transferPayerIdStateFactory: DefaultTransferPayerIdStateFactory(
            retryHandlerFactory: DefaultRetryHandlerFactory(
              maxRetries: Constants.states.transferPayerId.maxRetries
            ),
            payerId: try TransferId(from: value)
          )
        )
      }
    }()

    return DefaultBlippit(
      delegate: delegate,
      podz: podz,
      scenarioFactory: scenarioFactory,
      errorHandler: errorHandler
    )
  }
}
