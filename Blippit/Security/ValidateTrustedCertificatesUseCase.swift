//
//  ValidateTrustedCertificatesUseCase.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-13.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol ValidateTrustedCertificatesUseCase {
  func validateTrustedCertificates(_ certificates: [Certificate], for trust: Trust) throws
}
