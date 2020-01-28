//
//  DefaultGetCloudSessionStatusUseCase.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
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
      .resetQueryParameters()
      .addQueryParameter(sessionId)
      .build()

    return fetchDataUseCase.fetchData(with: request) { response, result in
      let result = result.flatMap { data in
        return Result(catching: {
          try CloudSessionStatus(try self.decoder.decode(GetCloudSessionStatusResponseDto.self, from: data))
        })
      }
      completion(response, result)
    }
  }
}
