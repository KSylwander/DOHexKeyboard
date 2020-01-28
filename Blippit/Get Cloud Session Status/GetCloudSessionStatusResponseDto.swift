//
//  GetCloudSessionStatusResponseDto.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

struct GetCloudSessionStatusResponseDto {
  enum Value: String, Decodable {
    case notStarted = "not_started"
    case established
    case done
  }
  let value: Value
}

extension GetCloudSessionStatusResponseDto: Decodable {
  private enum CodingKeys: String, CodingKey {
    case value = "status"
  }
}
