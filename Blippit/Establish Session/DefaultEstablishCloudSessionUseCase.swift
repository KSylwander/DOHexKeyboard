//
//  DefaultEstablishCloudSessionUseCase.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct DefaultEstablishCloudSessionUseCase {
  let appId: UUID

  let requestBuilder: URLRequestBuilder
  let encoder: Encoder
  let decoder: Decoder
  let uploadDataUseCase: UploadDataUseCase
}

extension DefaultEstablishCloudSessionUseCase: EstablishCloudSessionUseCase {
  func establishCloudSession(pid: UInt32, userId: String, completion: @escaping Completion) throws -> Cancellable {
    let request = requestBuilder.build()
    let data = try encoder.encode(EstablishCloudSessionRequestDto(pid: pid, userId: userId, appId: appId))

    return uploadDataUseCase.uploadData(with: request, from: data) { response, result in
      let sessionId = result.flatMap { data in
        return Result(catching: { try self.decoder.decode(EstablishCloudSessionResponseDto.self, from: data).sessionId })
      }
      completion(response, sessionId)
    }
  }
}
