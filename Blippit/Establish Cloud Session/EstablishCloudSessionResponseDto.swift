//
//  EstablishCloudSessionResponseDto.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

struct EstablishCloudSessionResponseDto {
  let sessionId: String
  let sessionToken: String
}

extension EstablishCloudSessionResponseDto: Decodable {
  private enum CodingKeys: String, CodingKey {
    case sessionId = "sessionid"
    case sessionToken = "sessiontoken"
  }
}
