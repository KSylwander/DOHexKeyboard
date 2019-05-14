//
//  SecurityError.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-13.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

enum SecurityError: Error {
  case applyTrustPoliciesFailed(OSStatus)
  case applyTrustAnchorCertificatesFailed(OSStatus)
  case evaluationFailed(OSStatus)
  case invalidTrustEvaluationResult(SecTrustResultType)
  case noTrustedCertificates
  case invalidCertificateData
}
