//
//  EstablishCloudSessionResponseDto.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct EstablishCloudSessionResponseDto {
  let sessionId: String
  let dataToken: String
}

extension EstablishCloudSessionResponseDto: Decodable {
  private enum CodingKeys: String, CodingKey {
    case sessionId = "sessionid"
    case dataToken = "datatoken"
  }
}
