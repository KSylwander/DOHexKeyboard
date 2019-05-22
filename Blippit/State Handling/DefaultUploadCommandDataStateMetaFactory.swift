//
//  DefaultUploadCommandDataStateMetaFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-22.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct DefaultUploadCommandDataStateMetaFactory {
  let uploadCommandDataUseCaseFactory: UploadCommandDataUseCaseFactory
}

extension DefaultUploadCommandDataStateMetaFactory: UploadCommandDataStateMetaFactory {
  func makeFactory(apiKey: UUID) -> UploadCommandDataStateFactory {
    return DefaultUploadCommandDataStateFactory(
      uploadCommandDataUseCase: uploadCommandDataUseCaseFactory.makeUseCase(apiKey: apiKey)
    )
  }
}
