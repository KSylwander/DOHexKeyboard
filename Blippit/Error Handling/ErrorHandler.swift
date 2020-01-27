//
//  ErrorHandler.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-11-19.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import PodzKit

struct ErrorHandler {}

extension ErrorHandler: ErrorHandling {
  func handleError(_ error: Error) -> Error {
    switch error {
    case PodzSetupError.notSupported:
      return BluetoothError.unsupported
    case PodzSetupError.invalidChannelFormat:
      return ConfigurationError.invalidChannelFormat
    case PodzError.bluetoothOff:
      return BluetoothError.poweredOff
    case PodzError.bluetoothUnauthorized:
      return BluetoothError.unauthorized
    case PodzError.locationDenied:
      return LocationError.denied
    case PodzError.locationNotDetermined:
      return LocationError.notDetermined
    case PodzError.locationRestricted:
      return LocationError.restricted
    case IdError.invalidSize:
      return PayloadError.invalidLength
    case IdError.invalidFormat:
      return PayloadError.invalidFormat
    default:
      return error
    }
  }
}
