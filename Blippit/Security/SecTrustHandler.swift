//
//  SecTrustHandler.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-13.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct SecTrustHandler {
  let setPolicies = (UnsafeBitCast.toSecPolicies >> ((UnsafeBitCast.toSecTrust >> SecTrustSetPolicies) |> flip)) |> flip

  let setAnchorCertificates
    = (UnsafeBitCast.toSecCertificates >> ((UnsafeBitCast.toSecTrust >> SecTrustSetAnchorCertificates) |> flip)) |> flip

  let evaluate = UnsafeBitCast.toSecTrust >> SecTrustEvaluate
  let getCertificateCount = UnsafeBitCast.toSecTrust >> SecTrustGetCertificateCount

  let getCertificateAtIndex
    = (UnsafeBitCast.toSecTrust >> SecTrustGetCertificateAtIndex) >>> (UnsafeBitCast.toCertificate |> curry(fmap))
}

extension SecTrustHandler: TrustHandling {}
