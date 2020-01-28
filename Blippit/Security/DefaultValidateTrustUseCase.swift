//
//  DefaultValidateTrustUseCase.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

struct DefaultValidateTrustUseCase {
  let trustHandler: TrustHandling
}

extension DefaultValidateTrustUseCase: ValidateTrustUseCase {
  func validateTrust(_ trust: Trust) throws {
    var result = SecTrustResultType.invalid

    let errorCode = trustHandler.evaluate(trust, &result)
    guard errorCode == errSecSuccess else {
      throw SecurityError.evaluationFailed(errorCode)
    }

    guard [.unspecified, .proceed].contains(result) else {
      throw SecurityError.invalidTrustEvaluationResult(result)
    }
  }
}
