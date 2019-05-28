//
//  DefaultUploadCommandDataUseCase.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct DefaultUploadCommandDataUseCase {
  let requestBuilder: URLRequestBuilder
  let encoder: Encoder
  let decoder: Decoder
  let uploadDataUseCase: UploadDataUseCase
}

extension DefaultUploadCommandDataUseCase: UploadCommandDataUseCase {
  func uploadCommandData(sessionId: String, data: CommandData, completion: @escaping Completion) -> Cancellable? {
    do {
      let request = requestBuilder
        .resetQueryParameters()
        .addQueryParameter(sessionId)
        .build()

      let requestDto = UploadCommandDataRequestDto(content: data)
      let data = try encoder.encode(requestDto)

      return uploadDataUseCase.uploadData(with: request, from: data) { response, result in
        let result = result.flatMap { data in
          return Result(catching: { try self.decoder.decode(UploadCommandDataResponseDto.self, from: data).dataToken })
        }
        completion(response, result)
      }
    } catch {
      completion(nil, .failure(error))
      return nil
    }
  }
}
