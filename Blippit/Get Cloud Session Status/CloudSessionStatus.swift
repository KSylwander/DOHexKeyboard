//
//  CloudSessionStatus.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-23.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
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
