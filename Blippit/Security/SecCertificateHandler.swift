//
//  SecCertificateHandler.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-13.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

/* Allows the certificate to be mocked when calling its handling functions */
struct SecCertificateHandler {
  /* `compose2` converts `(CFAllocator?, CFData) -> SecCertificate?` to `(CFAllocator?, CFData) -> Certificate?` */
  let createWithData = compose2(
    SecCertificateCreateWithData,
    /* Converts `(SecCertificate) -> Certificate` to `(SecCertificate?) -> Certificate?` */
    apply(
      UnsafeBitCast.toCertificate,
      curry(fmap)
    )
  )

  /* `compose` converts `(SecCertificate) -> CFData` to `(Certificate) -> CFData` */
  let copyData = compose(UnsafeBitCast.toSecCertificate, SecCertificateCopyData)
}

extension SecCertificateHandler: CertificateHandling {}
