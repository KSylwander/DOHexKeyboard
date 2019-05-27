//
//  CertificatePinning.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-13.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol CertificatePinning {
  func apply(to trust: Trust, domain: String) throws
}
