//
//  SecCertificateHandler.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

/* Allows the certificate to be mocked when calling its handling functions */
struct SecCertificateHandler {
  /* `compose2` converts `(CFAllocator?, CFData) -> SecCertificate?` to `(CFAllocator?, CFData) -> Certificate?` */
  let createWithData = compose2(
    SecCertificateCreateWithData,
    /* Converts `(SecCertificate) -> Certificate` to `(SecCertificate?) -> Certificate?` */
    curry(fmap)(UnsafeBitCast.toCertificate)
  )

  /* `compose` converts `(SecCertificate) -> CFData` to `(Certificate) -> CFData` */
  let copyData = compose(UnsafeBitCast.toSecCertificate, SecCertificateCopyData)
}

extension SecCertificateHandler: CertificateHandling {}
