//
//  SecTrustHandler.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-13.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

/* Allows the trust to be mocked when calling its handling functions */
struct SecTrustHandler {
  /* `apply` converts `([SecurityPolicy], Trust) -> OSStatus` to `(Trust, [SecurityPolicy]) -> OSStatus` */
  let setPolicies = apply(
    /* Converts `(CFTypeRef, Trust) -> OSStatus` to `([SecurityPolicy], Trust) -> OSStatus` */
    compose(
      UnsafeBitCast.toSecPolicies,
      /* Converts `(Trust, CFTypeRef) -> OSStatus` to `(CFTypeRef, Trust) -> OSStatus` */
      apply(
        /* Converts `(SecTrust, CFTypeRef) -> OSStatus` to `(Trust, CFTypeRef) -> OSStatus` */
        compose(
          UnsafeBitCast.toSecTrust,
          SecTrustSetPolicies
        ),
        flip
      )
    ),
    flip
  )

  /* `apply` converts `([Certificate], Trust) -> OSStatus` to `(Trust, [Certificate]) -> OSStatus` */
  let setAnchorCertificates = apply(
    /* Converts `(CFArray, Trust) -> OSStatus` to `([Certificate], Trust) -> OSStatus` */
    compose(
      UnsafeBitCast.toSecCertificates,
      /* Converts `(Trust, CFArray) -> OSStatus` to `(CFArray, Trust) -> OSStatus` */
      apply(
        /* Converts `(SecTrust, CFArray) -> OSStatus` to `(Trust, CFArray) -> OSStatus` */
        compose(
          UnsafeBitCast.toSecTrust,
          SecTrustSetAnchorCertificates
        ),
        flip
      )
    ),
    flip
  )

  /* `compose` converts `(SecTrust, UnsafeMutablePointer<SecTrustResultType>) -> OSStatus` to
   * `(Trust, UnsafeMutablePointer<SecTrustResultType>) -> OSStatus`
   */
  let evaluate = compose(UnsafeBitCast.toSecTrust, SecTrustEvaluate)

  /* `compose` converts `(SecTrust) -> CFIndex` to `(Trust) -> CFIndex` */
  let getCertificateCount = compose(UnsafeBitCast.toSecTrust, SecTrustGetCertificateCount)

  /* `compose2` converts `(Trust, CFIndex) -> SecCertificate?` to `(Trust, CFIndex) -> Certificate?` */
  let getCertificateAtIndex = compose2(
    /* Converts `(SecTrust, CFIndex) -> SecCertificate?` to `(Trust, CFIndex) -> SecCertificate?` */
    compose(
      UnsafeBitCast.toSecTrust,
      SecTrustGetCertificateAtIndex
    ),
    /* Converts `(SecCertificate) -> Certificate` to `(SecCertificate?) -> Certificate?` */
    apply(
      UnsafeBitCast.toCertificate,
      curry(fmap)
    )
  )
}

extension SecTrustHandler: TrustHandling {}
