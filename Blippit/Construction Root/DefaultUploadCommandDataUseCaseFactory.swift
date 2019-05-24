//
//  DefaultUploadCommandDataUseCaseFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-22.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct DefaultUploadCommandDataUseCaseFactory {
  let requestBuilderFactory: URLRequestBuilderFactory
  let encoder: Encoder
  let decoder: Decoder
  let uploadDataUseCase: UploadDataUseCase
}

extension DefaultUploadCommandDataUseCaseFactory: UploadCommandDataUseCaseFactory {
  func makeUseCase(apiKey: UUID) -> UploadCommandDataUseCase {
    return DefaultUploadCommandDataUseCase(
      requestBuilder: requestBuilderFactory.makeBuilder(apiKey: apiKey),
      encoder: encoder,
      decoder: decoder,
      uploadDataUseCase: uploadDataUseCase
    )
  }
}
