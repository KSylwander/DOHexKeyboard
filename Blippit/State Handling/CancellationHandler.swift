//
//  CancellationHandler.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

/* Conforming states will be notified when `cancel()` is called, if the stage also conforms to
 * `CancellablePodSessionState`
 */
protocol CancellationHandler: AnyObject {
  func handleCancellation()
}
