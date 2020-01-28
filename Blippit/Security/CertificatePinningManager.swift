//
//  CertificatePinningManager.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

final class CertificatePinningManager {
  private let pinnedCertificates: [Certificate]

  private let applyCertificatePinningUseCaseFactory: ApplyCertificatePinningUseCaseFactory
  private lazy var applyCertificatePinningUseCase = applyCertificatePinningUseCaseFactory.makeUseCase(
    pinnedCertificates: pinnedCertificates
  )

  private let validateTrustUseCase: ValidateTrustUseCase
  private let validateTrustedCertificatesUseCase: ValidateTrustedCertificatesUseCase

  init(pinnedCertificates: [Certificate],
       applyCertificatePinningUseCaseFactory: ApplyCertificatePinningUseCaseFactory,
       validateTrustUseCase: ValidateTrustUseCase,
       validateTrustedCertificatesUseCase: ValidateTrustedCertificatesUseCase) {

    self.pinnedCertificates = pinnedCertificates
    self.applyCertificatePinningUseCaseFactory = applyCertificatePinningUseCaseFactory
    self.validateTrustUseCase = validateTrustUseCase
    self.validateTrustedCertificatesUseCase = validateTrustedCertificatesUseCase
  }
}

extension CertificatePinningManager: CertificatePinning {
  func apply(to trust: Trust, domain: String) throws {
    try applyCertificatePinningUseCase.apply(to: trust, domain: domain)

    try validateTrustUseCase.validateTrust(trust)
    try validateTrustedCertificatesUseCase.validateTrustedCertificates(pinnedCertificates, for: trust)
  }
}
