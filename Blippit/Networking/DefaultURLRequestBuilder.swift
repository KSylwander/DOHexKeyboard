//
//  DefaultURLRequestBuilder.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-14.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

final class DefaultURLRequestBuilder {
  private let apiConfig: ApiConfig
  private let apiKey: UUID

  private var queryParameters = [CVarArg]()

  init(apiConfig: ApiConfig, apiKey: UUID) {
    self.apiConfig = apiConfig
    self.apiKey = apiKey
  }
}

extension DefaultURLRequestBuilder: URLRequestBuilder {
  func resetQueryParameters() -> Self {
    queryParameters.removeAll()
    return self
  }

  func addQueryParameter(_ queryParameter: CVarArg) -> Self {
    queryParameters.append(queryParameter)
    return self
  }

  func build() -> URLRequest {
    let baseUrl = URL(string: apiConfig.basePath)!

    let resource = String(format: apiConfig.resource, arguments: queryParameters)
    let resourceUrl = URL(string: resource, relativeTo: baseUrl)!

    var request = URLRequest(
      url: resourceUrl,
      cachePolicy: apiConfig.cachePolicy,
      timeoutInterval: apiConfig.timeoutInterval
    )

    request.httpMethod = apiConfig.method.rawValue
    request.addValue(apiConfig.contentType, forHTTPHeaderField: "Content-Type")

    /* TODO: Remove lowercasing call when the corresponding bug on the BSAC server is fixed (i.e., `x-apikey` checks on
     * the server are case-sensitive, when they shouldn't)
     */
    request.addValue(apiKey.uuidString.lowercased(), forHTTPHeaderField: "x-apikey")

    return request
  }
}
