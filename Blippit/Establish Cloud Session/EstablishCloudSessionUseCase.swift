//
//  EstablishCloudSessionUseCase.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol EstablishCloudSessionUseCase {
  typealias Completion = (_ response: HTTPURLResponse?, _ result: Result<String, Error>) -> Void
  func establishCloudSession(pid: UInt32, serviceInfo: ServiceInfo, completion: @escaping Completion) -> Cancellable?
}
