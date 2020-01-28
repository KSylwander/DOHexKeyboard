//
//  ApplyCertificatePinningUseCaseFactory.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol ApplyCertificatePinningUseCaseFactory {
  func makeUseCase(pinnedCertificates: [Certificate]) -> ApplyCertificatePinningUseCase
}
