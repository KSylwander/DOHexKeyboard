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
  func establishCloudSession(pid: UInt32, userId: String, completion: @escaping Completion) -> Cancellable? {
    do {
      let request = requestBuilder.build()
      let data = try encoder.encode(EstablishCloudSessionRequestDto(pid: pid, userId: userId, appId: appId))

      return uploadDataUseCase.uploadData(with: request, from: data) { response, result in
        let sessionId = result.flatMap { data in
          return Result(catching: { () -> String in
            let responseDto = try self.decoder.decode(EstablishCloudSessionResponseDto.self, from: data)
            return responseDto.sessionId
          })
        }
        completion(response, sessionId)
      }
    } catch {
      completion(nil, .failure(error))
      return nil
    }
  }
}
