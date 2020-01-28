//
//  SecPolicyHandler.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

/* Allows the security policy to mocked when calling its handling functions */
struct SecPolicyHandler {
  /* `compose2` converts `(Bool, CFString?) -> SecPolicy` to `(Bool, CFString?) -> SecurityPolicy` */
  let createSSL = compose2(SecPolicyCreateSSL, UnsafeBitCast.toSecurityPolicy)
}

extension SecPolicyHandler: SecurityPolicyHandling {}
