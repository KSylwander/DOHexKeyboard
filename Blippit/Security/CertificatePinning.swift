//
//  CertificatePinning.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol CertificatePinning {
  func apply(to trust: Trust, domain: String) throws
}
