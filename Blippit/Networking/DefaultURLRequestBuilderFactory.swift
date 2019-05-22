//
//  DefaultURLRequestBuilderFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-22.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct DefaultURLRequestBuilderFactory {
  let apiConfig: ApiConfig
}

extension DefaultURLRequestBuilderFactory: URLRequestBuilderFactory {
  func makeBuilder(apiKey: UUID) -> URLRequestBuilder {
    return DefaultURLRequestBuilder(apiConfig: apiConfig, apiKey: apiKey)
  }
}
