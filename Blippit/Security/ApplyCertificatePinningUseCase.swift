//
//  ApplyCertificatePinningUseCase.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol ApplyCertificatePinningUseCase {
  func apply(to trust: Trust, domain: String) throws
}
