//
//  UnsafeBitCast.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-14.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

/* Unsafe bit cast utility functions.
 *
 * Each of these helper functions standardize the types for a specific conversion. This standardization helps the
 * compiler infer the correct types when performing functional operations on a function.
 *
 * This is needed because a direct call to the `unsafeBitCast` function in the above case confuses the Swift compiler.
 */
enum UnsafeBitCast {
  static let toSecurityPolicy: (SecPolicy) -> SecurityPolicy = identity
  static let toSecPolicies: ([SecurityPolicy]) -> CFTypeRef = performAction
  static let toCertificate: (SecCertificate) -> Certificate = identity
  static let toSecCertificate: (Certificate) -> SecCertificate = performAction
  static let toSecCertificates: ([Certificate]) -> CFArray = performAction
  static let toSecTrust: (Trust) -> SecTrust = performAction

  static func performAction<T, U>(_ value: T) -> U {
    // swiftlint:disable force_cast
    return value as! U
    // swiftlint:enable force_cast
  }
}
