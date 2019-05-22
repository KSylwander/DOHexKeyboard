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
    do {
      let decoder = JSONDecoder()

      let policyHandler = SecPolicyHandler()
      let trustHandler = SecTrustHandler()
      let certificateHandler = SecCertificateHandler()

      let pinnedCertificates: [Certificate] = try {
        let bundle = Bundle(for: DefaultBlippit.self)
        let urls = bundle.urls(forResourcesWithExtension: "crt", subdirectory: nil)
        let certificateFactory = DefaultCertificateFactory(certificateHandling: certificateHandler)
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

      return DefaultBlippitFactory(
        startingStateFactory: DefaultStartingStateFactory(),
        startedStateFactory: DefaultStartedStateFactory(),
        setupTransferIdStateFactory: DefaultSetupTransferIdStateFactory(),
        establishCloudSessionStateMetaFactory: DefaultEstablishCloudSessionStateMetaFactory(
          establishCloudSessionUseCaseFactory: DefaultEstablishCloudSessionUseCaseFactory(
            requestBuilderFactory: DefaultURLRequestBuilderFactory(apiConfig: Constants.api.establishCloudSession.config),
            encoder: JSONEncoder(),
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
        uploadCommandDataStateMetaFactory: DefaultUploadCommandDataStateMetaFactory(
          uploadCommandDataUseCaseFactory: DefaultUploadCommandDataUseCaseFactory(
            requestBuilderFactory: DefaultURLRequestBuilderFactory(apiConfig: Constants.api.uploadCommandData.config),
            decoder: decoder,
            fetchDataUseCase: DefaultFetchDataUseCase(
              dataTaskFactory: urlSession,
              httpStatusCodeValidator: httpStatusCodeValidator
            )
          )
        ),
        transferDataTokenStateFactory: DefaultTransferDataTokenStateFactory(
          retryHandlerFactory: DefaultRetryHandlerFactory(maxRetries: Constants.states.transferDataToken.maxRetries)
        )
      )
    } catch {
      fatalError("Unable to setup construction root: \(error)")
    }
  }
}
