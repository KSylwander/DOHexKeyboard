//
//  SecPolicyHandler.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-13.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct SecPolicyHandler {
  let createSSL = compose2(SecPolicyCreateSSL, UnsafeBitCast.toSecurityPolicy)
}

extension SecPolicyHandler: SecurityPolicyHandling {}
