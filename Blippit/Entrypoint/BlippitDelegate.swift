//
//  BlippitDelegate.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

/**
 * The delegate for receiving events from `Blippit`.
 */
public protocol BlippitDelegate: AnyObject {
  /**
   * Called when `Blippit` changes state.
   */
  func blippit(_ blippit: Blippit, didChangeState state: BlippitState)

  /**
   * Called when an error occurs in the course of running `Blippit`.
   */
  func blippit(_ blippit: Blippit, didFailWithError error: Error)
}
