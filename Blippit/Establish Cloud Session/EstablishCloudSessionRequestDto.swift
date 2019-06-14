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
  let appId: UUID
  let serviceInfo: ServiceInfo
}

extension EstablishCloudSessionRequestDto: Encodable {
  private enum CodingKeys: String, CodingKey {
    case pid = "atid"
    case appId = "appid"
    case serviceInfo = "serviceinfo"
  }

  /* TODO: Remove `encode(to:)` method when `atid` parameter is fixed on the server (i.e., needs to be an int instead
   * of a string)
   */
  func encode(to encoder: Swift.Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode("\(pid)", forKey: .pid)
    try container.encode(appId, forKey: .appId)
    try container.encode(serviceInfo, forKey: .serviceInfo)
  }
}
