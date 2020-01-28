//
//  ValidateTrustUseCase.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol ValidateTrustUseCase {
  func validateTrust(_ trust: Trust) throws
}
