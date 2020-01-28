//
//  DataTaskFactory.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol DataTaskFactory {
  func dataTask(with request: URLRequest,
                completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
