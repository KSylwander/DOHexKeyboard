//
//  DefaultValidateTrustUseCase.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-13.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
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
