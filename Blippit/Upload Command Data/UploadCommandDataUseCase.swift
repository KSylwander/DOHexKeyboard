//
//  UploadCommandDataUseCase.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol UploadCommandDataUseCase {
  typealias Completion = (_ response: HTTPURLResponse?, _ result: Result<String, Error>) -> Void
  func uploadCommandData(sessionId: String, data: String, completion: @escaping Completion) -> Cancellable?
}
