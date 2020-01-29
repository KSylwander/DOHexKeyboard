//
//  BlippitSetup.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

/**
 * Main entrypoint where instances of the Blippit SDK can be created.
 */
public enum BlippitSetup {
  /**
   * Builds an instance of the Blippit SDK.
   *
   * - important: The behaviour of multiple `Blippit` instances created from this method is undefined.
   *
   * - throws: `BluetoothError`, `ConfigurationError`, and `LocationError`.
   */
  public static func setup(delegate: BlippitDelegate, onBlipPayload: Payload) throws -> Blippit {
    let errorHandler = ErrorHandler()
    return try errorHandler.handleErrors {
      return try setup(delegate: delegate,
                       onBlipPayload: onBlipPayload,
                       errorHandler: errorHandler)
    }
  }

  private static func setup(delegate: BlippitDelegate,
                            onBlipPayload: Payload,
                            errorHandler: ErrorHandling) throws -> Blippit {

    let podz = try PodzSetup.setup(channel: Constants.Credentials.Podz.channel)

    let scenarioFactory = PayerIdScenarioFactory(
      podz: podz,
      startingStateFactory: DefaultStartingStateFactory(),
      waitForPodStateFactory: DefaultWaitForPodStateFactory(),
      waitForBlipStateFactory: DefaultWaitForBlipStateFactory(),
      setupTransferIdStateFactory: DefaultSetupTransferIdStateFactory(),
      transferPayerIdStateFactory: DefaultTransferPayerIdStateFactory(
        retryHandlerFactory: DefaultRetryHandlerFactory(
          maxRetries: Constants.States.TransferPayerId.maxRetries
        ),
        payerId: try TransferId(from: onBlipPayload.value)))

    return DefaultBlippit(
      delegate: delegate,
      podz: podz,
      scenarioFactory: scenarioFactory,
      errorHandler: errorHandler
    )
  }
}
