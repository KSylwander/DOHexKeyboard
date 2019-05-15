//
//  EstablishSessionRequestDto.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct EstablishSessionRequestDto {
  let pid: UInt32
  let userId: String
  let appId: UUID
}

extension EstablishSessionRequestDto: Encodable {
  private enum CodingKeys: String, CodingKey {
    case pid = "atid"
    case userId = "appid"
    case appId = "userid"
  }
}
