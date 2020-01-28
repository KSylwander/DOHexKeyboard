//
//  TrustHandling.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol TrustHandling {
  var setPolicies: (_ trust: Trust, _ policies: [SecurityPolicy]) -> OSStatus { get }
  var setAnchorCertificates: (_ trust: Trust, _ anchorCertificates: [Certificate]) -> OSStatus { get }
  var evaluate: (_ trust: Trust, _ result: UnsafeMutablePointer<SecTrustResultType>) -> OSStatus { get }
  var getCertificateCount: (_ trust: Trust) -> CFIndex { get }
  var getCertificateAtIndex: (_ trust: Trust, _ ix: CFIndex) -> Certificate? { get }
}
