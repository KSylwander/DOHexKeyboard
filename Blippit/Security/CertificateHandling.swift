//
//  CertificateHandling.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-13.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol CertificateHandling {
  var createWithData: (_ allocator: CFAllocator?, _ data: CFData) -> Certificate? { get }
  var copyData: (_ certificate: Certificate) -> CFData { get }
}
