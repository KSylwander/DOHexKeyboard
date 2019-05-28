//
//  GetCloudSessionStatusResponseDto.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-23.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct GetCloudSessionStatusResponseDto {
  let status: CloudSessionStatus
}

extension GetCloudSessionStatusResponseDto: Decodable {}
