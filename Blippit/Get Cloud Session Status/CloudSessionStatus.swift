//
//  CloudSessionStatus.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-23.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

enum CloudSessionStatus: String {
  case notStarted = "not_started"
  case established
  case done
}

extension CloudSessionStatus: Decodable {}
