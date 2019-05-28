//
//  URLRequestBuilder.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-14.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol URLRequestBuilder {
  func resetQueryParameters() -> Self
  func addQueryParameter(_ queryParameter: CVarArg) -> Self

  func build() -> URLRequest
}
