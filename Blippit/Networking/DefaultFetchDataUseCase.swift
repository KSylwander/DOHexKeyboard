//
//  DefaultFetchDataUseCase.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-06.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct DefaultFetchDataUseCase {
  let dataTaskFactory: DataTaskFactory
}

extension DefaultFetchDataUseCase: FetchDataUseCase {
  func fetchData(with request: URLRequest, completion: @escaping FetchDataUseCase.Completion) -> Cancellable {
    let task = dataTaskFactory.dataTask(with: request) { data, response, error in
      let response = response.map { $0 as! HTTPURLResponse }

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
