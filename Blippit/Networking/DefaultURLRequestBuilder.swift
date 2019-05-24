//
//  DefaultURLRequestBuilder.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-14.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct DefaultURLRequestBuilder {
  let apiConfig: ApiConfig
  let apiKey: UUID
}

extension DefaultURLRequestBuilder: URLRequestBuilder {
  func build() -> URLRequest {
    let baseUrl = URL(string: apiConfig.basePath)!
    let resourceUrl = URL(string: apiConfig.resource, relativeTo: baseUrl)!

    var request = URLRequest(
      url: resourceUrl,
      cachePolicy: apiConfig.cachePolicy,
      timeoutInterval: apiConfig.timeoutInterval
    )

    request.httpMethod = apiConfig.method.rawValue
    request.addValue(apiKey.uuidString, forHTTPHeaderField: "x-apikey")

    return request
  }
}
