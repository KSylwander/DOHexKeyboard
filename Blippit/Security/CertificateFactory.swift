//
//  CertificateFactory.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol CertificateFactory {
  func makeCertificate(url: URL) throws -> Certificate
}
