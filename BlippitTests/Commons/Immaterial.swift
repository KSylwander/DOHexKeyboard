//
//  Immaterial.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

func immaterial() -> URLResponse {
  return HTTPURLResponse()
}

func immaterial() -> URLRequest {
  return URLRequest(url: URL(string: "https://www.crunchfish.com/")!)
}

func immaterial() -> Data {
  return Data("Hello, world!".utf8)
}
