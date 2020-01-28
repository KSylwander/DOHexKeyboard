//
//  SecTrustHandler.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

/* Allows the trust to be mocked when calling its handling functions */
struct SecTrustHandler {
  /* `flip` converts `([SecurityPolicy], Trust) -> OSStatus` to `(Trust, [SecurityPolicy]) -> OSStatus` */
  let setPolicies = flip(
    /* Converts `(CFTypeRef, Trust) -> OSStatus` to `([SecurityPolicy], Trust) -> OSStatus` */
    compose(
      UnsafeBitCast.toSecPolicies,
      /* Converts `(Trust, CFTypeRef) -> OSStatus` to `(CFTypeRef, Trust) -> OSStatus` */
      flip(
        /* Converts `(SecTrust, CFTypeRef) -> OSStatus` to `(Trust, CFTypeRef) -> OSStatus` */
        compose(
          UnsafeBitCast.toSecTrust,
          SecTrustSetPolicies
        )
      )
    )
  )

  /* `flip` converts `([Certificate], Trust) -> OSStatus` to `(Trust, [Certificate]) -> OSStatus` */
  let setAnchorCertificates = flip(
    /* Converts `(CFArray, Trust) -> OSStatus` to `([Certificate], Trust) -> OSStatus` */
    compose(
      UnsafeBitCast.toSecCertificates,
      /* Converts `(Trust, CFArray) -> OSStatus` to `(CFArray, Trust) -> OSStatus` */
      flip(
        /* Converts `(SecTrust, CFArray) -> OSStatus` to `(Trust, CFArray) -> OSStatus` */
        compose(
          UnsafeBitCast.toSecTrust,
          SecTrustSetAnchorCertificates
        )
      )
    )
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
    curry(fmap)(UnsafeBitCast.toCertificate)
  )
}

extension SecTrustHandler: TrustHandling {}
