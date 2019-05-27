//
//  UploadDataUseCase.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol UploadDataUseCase {
  typealias Completion = (_ response: HTTPURLResponse?, _ result: Result<Data, Error>) -> Void
  @discardableResult func uploadData(with request: URLRequest,
                                     from data: Data,
                                     completion: @escaping Completion) -> Cancellable
}
