//
//  FetchDataUseCase.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol FetchDataUseCase {
  typealias Completion = (_ response: HTTPURLResponse?, _ result: Result<Data, Error>) -> Void
  @discardableResult func fetchData(with request: URLRequest, completion: @escaping Completion) -> Cancellable
}
