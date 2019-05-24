//
//  UploadCommandDataRequestDto.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-24.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct UploadCommandDataRequestDto {
  let content: CommandData
}

extension UploadCommandDataRequestDto: Encodable {}
