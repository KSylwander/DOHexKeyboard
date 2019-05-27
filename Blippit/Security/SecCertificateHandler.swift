//
//  SecCertificateHandler.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-13.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct SecCertificateHandler {
  let createWithData = compose2(SecCertificateCreateWithData, apply(UnsafeBitCast.toCertificate, curry(fmap)))
  let copyData = compose(UnsafeBitCast.toSecCertificate, SecCertificateCopyData)
}

extension SecCertificateHandler: CertificateHandling {}
