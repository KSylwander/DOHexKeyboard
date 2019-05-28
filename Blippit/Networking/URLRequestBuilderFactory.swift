//
//  URLRequestBuilderFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-22.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol URLRequestBuilderFactory {
  func makeBuilder(apiKey: UUID) -> URLRequestBuilder
}
