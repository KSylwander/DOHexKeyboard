//
//  DefaultEstablishCloudSessionUseCaseFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct DefaultEstablishCloudSessionUseCaseFactory {
  let requestBuilder: URLRequestBuilder
  let encoder: Encoder
  let decoder: Decoder
  let uploadDataUseCase: UploadDataUseCase
}

extension DefaultEstablishCloudSessionUseCaseFactory: EstablishCloudSessionUseCaseFactory {
  func makeUseCase(appId: UUID) -> EstablishCloudSessionUseCase {
    return DefaultEstablishCloudSessionUseCase(
      appId: appId,
      requestBuilder: requestBuilder,
      encoder: encoder,
      decoder: decoder,
      uploadDataUseCase: uploadDataUseCase
    )
  }
}
