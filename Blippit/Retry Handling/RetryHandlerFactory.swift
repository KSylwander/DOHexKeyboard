//
//  RetryHandlerFactory.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol RetryHandlerFactory {
  func makeRetryHandler(action: @escaping () throws -> Void) -> RetryHandling
}
