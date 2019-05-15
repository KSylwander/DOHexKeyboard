//
//  EstablishSessionRequestUseCase.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol EstablishSessionRequestUseCase {
  typealias Completion = (_ response: HTTPURLResponse?, _ result: Result<String, Error>) -> Void
  func establishSession(pid: UInt32, userId: String, completion: @escaping Completion) throws -> Cancellable
}
