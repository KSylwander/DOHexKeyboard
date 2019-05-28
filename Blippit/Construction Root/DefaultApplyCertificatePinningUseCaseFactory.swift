//
//  DefaultApplyCertificatePinningUseCaseFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-13.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
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
