//
//  GetCloudSessionStatusUseCase.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol GetCloudSessionStatusUseCase {
  typealias Completion = (_ response: HTTPURLResponse?, _ result: Result<CloudSessionStatus, Error>) -> Void
  func getCloudSessionStatus(sessionId: String, completion: @escaping Completion) -> Cancellable?
}
