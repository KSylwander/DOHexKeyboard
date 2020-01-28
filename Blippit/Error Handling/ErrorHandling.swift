//
//  ErrorHandling.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

protocol ErrorHandling {
  func handleError(_ error: Error) -> Error
}

extension ErrorHandling {
  func handleErrors<T>(in action: () throws -> T) throws -> T {
    do {
      return try action()
    } catch {
      throw handleError(error)
    }
  }
}
