//
//  SecPolicyHandler.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-13.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

/* Allows the security policy to mocked when calling its handling functions */
struct SecPolicyHandler {
  /* `compose2` converts `(Bool, CFString?) -> SecPolicy` to `(Bool, CFString?) -> SecurityPolicy` */
  let createSSL = compose2(SecPolicyCreateSSL, UnsafeBitCast.toSecurityPolicy)
}

extension SecPolicyHandler: SecurityPolicyHandling {}
