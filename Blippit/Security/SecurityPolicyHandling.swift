//
//  SecurityPolicyHandling.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol SecurityPolicyHandling {
  var createSSL: (_ server: Bool, _ hostname: CFString?) -> SecurityPolicy { get }
}
