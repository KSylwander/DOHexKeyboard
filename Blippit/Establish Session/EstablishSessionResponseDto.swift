//
//  EstablishSessionResponseDto.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct EstablishSessionResponseDto {
  let sessionId: String
}

extension EstablishSessionResponseDto: Decodable {
  private enum CodingKeys: String, CodingKey {
    case sessionId = "sessionid"
  }
}
