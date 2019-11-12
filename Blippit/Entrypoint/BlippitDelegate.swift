//
//  BlippitDelegate.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

/**
 * The delegate for receiving events from the Blippit SDK.
 */
public protocol BlippitDelegate: AnyObject {
  /**
   * Called when the Blippit SDK changes state.
   */
  func blippit(_ blippit: Blippit, didChangeState state: BlippitState)

  /**
   * Called when an error occurs in the course of running the Blippit SDK.
   */
  func blippit(_ blippit: Blippit, didFailWithError error: Error)
}
