//
//  UnsafeBitCast.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-14.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

enum UnsafeBitCast {
  static let toSecurityPolicy: (SecPolicy) -> SecurityPolicy = performAction
  static let toSecPolicies: ([SecurityPolicy]) -> CFTypeRef = performAction
  static let toCertificate: (SecCertificate) -> Certificate = performAction
  static let toSecCertificate: (Certificate) -> SecCertificate = performAction
  static let toSecCertificates: ([Certificate]) -> CFArray = performAction
  static let toSecTrust: (Trust) -> SecTrust = performAction

  static func performAction<T, U>(_ value: T) -> U {
    return Swift.unsafeBitCast(value, to: U.self)
  }
}
