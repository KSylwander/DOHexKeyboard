//
//  DefaultUploadDataUseCase.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

struct DefaultUploadDataUseCase {
  let uploadTaskFactory: UploadTaskFactory
  let responseValidator: HttpUrlResponseValidator
}

extension DefaultUploadDataUseCase: UploadDataUseCase {
  @discardableResult func uploadData(with request: URLRequest,
                                     from data: Data,
                                     completion: @escaping Completion) -> Cancellable {

    Log.debug(.public(request.logDescription(.long)))
    let task = uploadTaskFactory.uploadTask(with: request, from: data) { data, response, error in
      // swiftlint:disable force_cast
      let response = response.map { $0 as! HTTPURLResponse }
      // swiftlint:enable force_cast
      Log.debug(.public("""
        \(response.logDescription(with: request)), Data: \(data.logDescription), Error: \(error.logDescription)
        """
      ))

      if let response = response, let error = self.responseValidator.validate(response, data: data) {
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
