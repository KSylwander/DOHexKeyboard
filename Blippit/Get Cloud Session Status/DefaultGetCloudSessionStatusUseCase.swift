//
//  DefaultGetCloudSessionStatusUseCase.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-23.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct DefaultGetCloudSessionStatusUseCase {
  let requestBuilder: URLRequestBuilder
  let decoder: Decoder
  let fetchDataUseCase: FetchDataUseCase
}

extension DefaultGetCloudSessionStatusUseCase: GetCloudSessionStatusUseCase {
  func getCloudSessionStatus(sessionId: String, completion: @escaping Completion) -> Cancellable? {
    let request = requestBuilder
      .addQueryParameter(sessionId)
      .build()

    return fetchDataUseCase.fetchData(with: request) { response, result in
      let result = result.flatMap { data in
        return Result(catching: { try self.decoder.decode(GetCloudSessionStatusResponseDto.self, from: data).status })
      }
      completion(response, result)
    }
  }
}
