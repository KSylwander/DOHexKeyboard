//
//  EstablishCloudSessionUseCase.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol EstablishCloudSessionUseCase {
  typealias Completion = (_ response: HTTPURLResponse?, _ result: Result<CloudSession, Error>) -> Void
  func establishCloudSession(pid: UInt32, serviceInfo: ServiceInfo, completion: @escaping Completion) -> Cancellable?
}
