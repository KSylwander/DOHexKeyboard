//
//  UploadCommandDataResponseDto.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct UploadCommandDataResponseDto {
  let dataToken: String
}

extension UploadCommandDataResponseDto: Decodable {
  private enum CodingKeys: String, CodingKey {
    case dataToken = "datatoken"
  }
}
