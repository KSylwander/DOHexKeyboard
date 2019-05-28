//
//  EstablishCloudSessionRequestDto.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct EstablishCloudSessionRequestDto {
  let pid: UInt32
  let userId: String
  let appId: UUID
}

extension EstablishCloudSessionRequestDto: Encodable {
  private enum CodingKeys: String, CodingKey {
    case pid = "atid"
    case userId = "userid"
    case appId = "appid"
  }

  func encode(to encoder: Swift.Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode("\(pid)", forKey: .pid)
    try container.encode(userId, forKey: .userId)
    try container.encode(appId, forKey: .appId)
  }
}
