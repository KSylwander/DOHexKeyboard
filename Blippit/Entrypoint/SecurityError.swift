//
//  SecurityError.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-13.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
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
