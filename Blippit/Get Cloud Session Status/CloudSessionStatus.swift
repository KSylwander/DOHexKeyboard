//
//  CloudSessionStatus.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

enum CloudSessionStatus {
  case notStarted
  case established
  case done

  init(_ response: GetCloudSessionStatusResponseDto) throws {
    switch response.value {
    case .notStarted:
      self = .notStarted
    case .established:
      self = .established
    case .done:
      self = .done
    }
  }
}
