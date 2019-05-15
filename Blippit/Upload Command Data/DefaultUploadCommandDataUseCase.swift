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
  let decoder: Decoder
  let fetchDataUseCase: FetchDataUseCase
}

extension DefaultUploadCommandDataUseCase: UploadCommandDataUseCase {
  func uploadCommandData(sessionId: String, data: String, completion: @escaping Completion) -> Cancellable? {
    let request = requestBuilder.build()
    return fetchDataUseCase.fetchData(with: request) { response, result in
      let dataToken = result.flatMap { data in
        return Result(catching: { try self.decoder.decode(UploadCommandDataResponseDto.self, from: data).dataToken })
      }
      completion(response, dataToken)
    }
  }
}
