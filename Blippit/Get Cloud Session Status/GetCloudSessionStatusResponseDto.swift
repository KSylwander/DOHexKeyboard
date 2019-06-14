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
  let content: Content?
}

extension GetCloudSessionStatusResponseDto: Decodable {
  private enum CodingKeys: String, CodingKey {
    case value = "status"
    case content
  }

  /* TODO: Remove `init(from:)` when `content` field is fixed on the server (i.e., needs to be `null` if there is no
   * content instead of an empty string)
   */
  init(from decoder: Swift.Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    value = try container.decode(Value.self, forKey: .value)

    do {
      content = try container.decode(Content.self, forKey: .content)
    } catch DecodingError.typeMismatch {
      content = nil
    }
  }
}
