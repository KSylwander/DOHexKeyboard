//
//  EstablishCloudSessionRequestDto.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
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
}
