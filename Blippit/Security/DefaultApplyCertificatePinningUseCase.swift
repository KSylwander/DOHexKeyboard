//
//  DefaultApplyCertificatePinningUseCase.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

struct DefaultApplyCertificatePinningUseCase {
  let pinnedCertificates: [Certificate]

  let policyHandler: SecurityPolicyHandling
  let trustHandler: TrustHandling
}

extension DefaultApplyCertificatePinningUseCase: ApplyCertificatePinningUseCase {
  func apply(to trust: Trust, domain: String) throws {
    let policies = [
      policyHandler.createSSL(true, domain as CFString)
    ]
    try applyPolicies(policies, to: trust)

    try applyAnchorCertificates(pinnedCertificates, to: trust)
  }

  private func applyPolicies(_ policies: [SecurityPolicy], to trust: Trust) throws {
    let errorCode = trustHandler.setPolicies(trust, policies)
    guard errorCode == errSecSuccess else {
      throw SecurityError.applyTrustPoliciesFailed(errorCode)
    }
  }

  private func applyAnchorCertificates(_ anchorCertificates: [Certificate], to trust: Trust) throws {
    let errorCode = trustHandler.setAnchorCertificates(trust, anchorCertificates)
    guard errorCode == errSecSuccess else {
      throw SecurityError.applyTrustAnchorCertificatesFailed(errorCode)
    }
  }
}
