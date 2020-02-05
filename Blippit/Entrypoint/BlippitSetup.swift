//
//  BlippitSetup.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

/**
 * Main entrypoint where instances of BlippitKit can be created.
 */
public enum BlippitSetup {
  /**
   * Builds an instance of `Blippit`.
   *
   * - important: The behaviour of multiple `Blippit` instances created from this method is undefined.
   *
   * - throws: `BluetoothError`
   */
  public static func setup(delegate: BlippitDelegate, onBlipPayload: Payload) throws -> Blippit {
    let errorHandler = ErrorHandler()
    return try errorHandler.handleErrors {
      return try setup(delegate: delegate, onBlipPayload: onBlipPayload, errorHandler: errorHandler)
    }
  }

  private static func setup(delegate: BlippitDelegate,
                            onBlipPayload: Payload,
                            errorHandler: ErrorHandling) throws -> Blippit {

    let propertyStorage = PropertyStorage.shared

    let podz = try PodzSetup.setup(channel: propertyStorage.value(for: PropertyKeys.Podz.channel))

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
        payerId: onBlipPayload.transferId
      )
    )

    return DefaultBlippit(
      delegate: delegate,
      podz: podz,
      scenarioFactory: scenarioFactory,
      errorHandler: errorHandler
    )
  }
}
