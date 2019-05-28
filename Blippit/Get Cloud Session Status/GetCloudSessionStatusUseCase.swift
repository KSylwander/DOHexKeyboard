//
//  GetCloudSessionStatusUseCase.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-23.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol GetCloudSessionStatusUseCase {
  typealias Completion = (_ response: HTTPURLResponse?, _ result: Result<CloudSessionStatus, Error>) -> Void
  func getCloudSessionStatus(sessionId: String, completion: @escaping Completion) -> Cancellable?
}
