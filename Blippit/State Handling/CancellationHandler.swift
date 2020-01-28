//
//  CancellationHandler.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

/* Conforming states will be notified when `cancel()` is called, if the stage also conforms to
 * `CancellablePodSessionState`
 */
protocol CancellationHandler: AnyObject {
  func handleCancellation()
}
