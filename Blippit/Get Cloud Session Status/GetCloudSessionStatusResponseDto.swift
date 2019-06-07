//
//  GetCloudSessionStatusResponseDto.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-23.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct GetCloudSessionStatusResponseDto {
  enum Value: String, Decodable {
    case notStarted = "not_started"
    case established
    case done
  }
  let value: Value

  struct Content: Decodable {
    let token: String
  }
  let content: Content
}

extension GetCloudSessionStatusResponseDto: Decodable {
  private enum CodingKeys: String, CodingKey {
    case value = "status"
    case content
  }
}
