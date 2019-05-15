//
//  UploadTaskFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol UploadTaskFactory {
  func uploadTask(with request: URLRequest,
                  from bodyData: Data?,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionUploadTask
}
