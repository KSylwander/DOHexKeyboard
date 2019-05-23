//
//  DefaultGetCloudSessionStatusUseCaseFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-23.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct DefaultGetCloudSessionStatusUseCaseFactory {
  let requestBuilderFactory: URLRequestBuilderFactory
  let decoder: Decoder
  let fetchDataUseCase: FetchDataUseCase
}

extension DefaultGetCloudSessionStatusUseCaseFactory: GetCloudSessionStatusUseCaseFactory {
  func makeUseCase(apiKey: UUID) -> GetCloudSessionStatusUseCase {
    return DefaultGetCloudSessionStatusUseCase(
      requestBuilder: requestBuilderFactory.makeBuilder(apiKey: apiKey),
      decoder: decoder,
      fetchDataUseCase: fetchDataUseCase
    )
  }
}
