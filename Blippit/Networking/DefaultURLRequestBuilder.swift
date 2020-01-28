//
//  DefaultURLRequestBuilder.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
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
    request.addValue(apiKey.uuidString, forHTTPHeaderField: "x-apikey")

    return request
  }
}
