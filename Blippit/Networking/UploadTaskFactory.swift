//
//  UploadTaskFactory.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol UploadTaskFactory {
  func uploadTask(with request: URLRequest,
                  from bodyData: Data?,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask
}
