//
//  SecurityError.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

// swiftlint:disable todo
/* TODO: Make public when `_BlippitMode.payment` is exposed publicly */
// swiftlint:enable todo
enum SecurityError: Error {
  case applyTrustPoliciesFailed(OSStatus)
  case applyTrustAnchorCertificatesFailed(OSStatus)
  case evaluationFailed(OSStatus)
  case invalidTrustEvaluationResult(SecTrustResultType)
  case noTrustedCertificates
  case invalidCertificateData
}
