//
//  CertificateHandling.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol CertificateHandling {
  var createWithData: (_ allocator: CFAllocator?, _ data: CFData) -> Certificate? { get }
  var copyData: (_ certificate: Certificate) -> CFData { get }
}
