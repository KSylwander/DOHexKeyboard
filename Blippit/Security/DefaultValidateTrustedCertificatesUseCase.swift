//
//  DefaultValidateTrustedCertificatesUseCase.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-13.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct DefaultValidateTrustedCertificatesUseCase {
  let trustHandler: TrustHandling
  let certificateHandler: CertificateHandling
}

extension DefaultValidateTrustedCertificatesUseCase: ValidateTrustedCertificatesUseCase {
  func validateTrustedCertificates(_ certificates: [Certificate], for trust: Trust) throws {
    /* We check that more than one certificate is trusted. We do this because when the present certificate expires
     * we may have an overlap period with two certificates trusted in app to smooth the transition to the new one.
     */

    let trustCertificateData = (0..<trustHandler.getCertificateCount(trust))
      .map { trustHandler.getCertificateAtIndex(trust, $0)! }
      .map { certificateHandler.copyData($0) as Data }

    let trustedCertificateCount = certificates
      .map { certificateHandler.copyData($0) as Data }
      .filter(trustCertificateData.contains)
      .count

    guard trustedCertificateCount > 0 else {
      throw SecurityError.noTrustedCertificates
    }
  }
}
