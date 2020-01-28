//
//  AsyncRetryHandlerFactory.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol AsyncRetryHandlerFactory {
  func makeRetryHandler(action: @escaping () -> Void) -> AsyncRetryHandling
}
