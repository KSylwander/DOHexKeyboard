//
//  FetchDataUseCase.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-06.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol FetchDataUseCase {
  typealias Completion = (_ response: HTTPURLResponse?, _ result: Result<Data, Error>) -> Void
  func fetchData(with request: URLRequest, completion: @escaping Completion) -> Cancellable
}
