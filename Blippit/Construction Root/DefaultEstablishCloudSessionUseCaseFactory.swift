//
//  DefaultEstablishCloudSessionUseCaseFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct DefaultEstablishCloudSessionUseCaseFactory {
  let requestBuilderFactory: URLRequestBuilderFactory
  let encoder: Encoder
  let decoder: Decoder
  let uploadDataUseCase: UploadDataUseCase
}

extension DefaultEstablishCloudSessionUseCaseFactory: EstablishCloudSessionUseCaseFactory {
  func makeUseCase(apiKey: UUID, appId: UUID) -> EstablishCloudSessionUseCase {
    return DefaultEstablishCloudSessionUseCase(
      appId: appId,
      requestBuilder: requestBuilderFactory.makeBuilder(apiKey: apiKey),
      encoder: encoder,
      decoder: decoder,
      uploadDataUseCase: uploadDataUseCase
    )
  }
}
