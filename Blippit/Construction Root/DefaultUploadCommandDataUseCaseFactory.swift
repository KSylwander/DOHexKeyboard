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
  let decoder: Decoder
  let fetchDataUseCase: FetchDataUseCase
}

extension DefaultUploadCommandDataUseCaseFactory: UploadCommandDataUseCaseFactory {
  func makeUseCase(apiKey: UUID) -> UploadCommandDataUseCase {
    return DefaultUploadCommandDataUseCase(
      requestBuilder: requestBuilderFactory.makeBuilder(apiKey: apiKey),
      decoder: decoder,
      fetchDataUseCase: fetchDataUseCase
    )
  }
}
