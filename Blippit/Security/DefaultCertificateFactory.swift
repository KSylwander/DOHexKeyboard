//
//  DefaultCertificateFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-13.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct DefaultCertificateFactory {
  let certificateHandler: CertificateHandling
}

extension DefaultCertificateFactory: CertificateFactory {
  func makeCertificate(url: URL) throws -> Certificate {
    let data = try Data(contentsOf: url)
    guard let certificate = certificateHandler.createWithData(nil, data as CFData) else {
      throw SecurityError.invalidCertificateData
    }
    return certificate
  }
}
