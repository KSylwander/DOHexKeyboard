//
//  ApplyCertificatePinningUseCaseFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-13.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol ApplyCertificatePinningUseCaseFactory {
  func makeUseCase(pinnedCertificates: [Certificate]) -> ApplyCertificatePinningUseCase
}
