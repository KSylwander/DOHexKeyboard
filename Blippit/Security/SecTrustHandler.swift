//
//  SecTrustHandler.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-13.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct SecTrustHandler {
  let setPolicies = apply(
    UnsafeBitCast.toSecPolicies >> apply(UnsafeBitCast.toSecTrust >> SecTrustSetPolicies, flip),
    flip
  )

  let setAnchorCertificates = apply(
    UnsafeBitCast.toSecCertificates >> apply(UnsafeBitCast.toSecTrust >> SecTrustSetAnchorCertificates, flip),
    flip
  )

  let evaluate = UnsafeBitCast.toSecTrust >> SecTrustEvaluate
  let getCertificateCount = UnsafeBitCast.toSecTrust >> SecTrustGetCertificateCount

  let getCertificateAtIndex
    = (UnsafeBitCast.toSecTrust >> SecTrustGetCertificateAtIndex) >>> apply(UnsafeBitCast.toCertificate, curry(fmap))
}

extension SecTrustHandler: TrustHandling {}
