//
//  URLRequestBuilder.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol URLRequestBuilder {
  func resetQueryParameters() -> Self
  func addQueryParameter(_ queryParameter: CVarArg) -> Self

  func build() -> URLRequest
}
