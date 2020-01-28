//
//  DefaultCertificateFactory.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
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
