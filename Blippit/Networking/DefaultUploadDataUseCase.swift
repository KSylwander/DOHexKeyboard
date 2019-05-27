//
//  DefaultUploadDataUseCase.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct DefaultUploadDataUseCase {
  let uploadTaskFactory: UploadTaskFactory
  let httpStatusCodeValidator: HttpStatusCodeValidator
}

extension DefaultUploadDataUseCase: UploadDataUseCase {
  @discardableResult func uploadData(with request: URLRequest,
                                     from data: Data,
                                     completion: @escaping Completion) -> Cancellable {

    let task = uploadTaskFactory.uploadTask(with: request, from: data) { data, response, error in
      let response = response.map { $0 as! HTTPURLResponse }

      if let statusCode = response?.statusCode, let error = self.httpStatusCodeValidator.validate(statusCode) {
        completion(response, .failure(error))
        return
      }

      if let error = error {
        completion(response, .failure(error))
        return
      }

      completion(response, .success(data!))
    }
    task.resume()

    return task
  }
}
