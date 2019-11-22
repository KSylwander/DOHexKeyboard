//
//  ErrorHandling.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-11-19.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
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
