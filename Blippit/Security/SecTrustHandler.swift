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
    compose(UnsafeBitCast.toSecPolicies, apply(compose(UnsafeBitCast.toSecTrust, SecTrustSetPolicies), flip)),
    flip
  )

  let setAnchorCertificates = apply(
    compose(
      UnsafeBitCast.toSecCertificates,
      apply(compose(UnsafeBitCast.toSecTrust, SecTrustSetAnchorCertificates), flip)
    ),
    flip
  )

  let evaluate = compose(UnsafeBitCast.toSecTrust, SecTrustEvaluate)
  let getCertificateCount = compose(UnsafeBitCast.toSecTrust, SecTrustGetCertificateCount)

  let getCertificateAtIndex = compose2(
    compose(UnsafeBitCast.toSecTrust, SecTrustGetCertificateAtIndex),
    apply(UnsafeBitCast.toCertificate, curry(fmap))
  )
}

extension SecTrustHandler: TrustHandling {}
