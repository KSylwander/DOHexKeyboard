//
//  ValidateTrustedCertificatesUseCase.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol ValidateTrustedCertificatesUseCase {
  func validateTrustedCertificates(_ certificates: [Certificate], for trust: Trust) throws
}
