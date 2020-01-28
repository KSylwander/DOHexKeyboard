//
//  DefaultApplyCertificatePinningUseCaseFactory.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

struct DefaultApplyCertificatePinningUseCaseFactory {
  let policyHandler: SecurityPolicyHandling
  let trustHandler: TrustHandling
}

extension DefaultApplyCertificatePinningUseCaseFactory: ApplyCertificatePinningUseCaseFactory {
  func makeUseCase(pinnedCertificates: [Certificate]) -> ApplyCertificatePinningUseCase {
    return DefaultApplyCertificatePinningUseCase(
      pinnedCertificates: pinnedCertificates,
      policyHandler: policyHandler,
      trustHandler: trustHandler
    )
  }
}
