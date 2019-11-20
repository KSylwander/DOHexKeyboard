//
//  LocationError.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-11-19.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

/* TODO: Make public when `_BlippitMode.payment` is exposed publicly (i.e., revert the access modifier change to the
 * `LocationError` enum below).
 */

/**
 * Errors that may occur in the location services setup stage.
 *
 * Receive these errors by implementing the `BlippitDelegate.blippit(_:didFailWithError:)` method, and passing the
 * delegate implementation to the `BlippitSetup.setup(delegate:configuration:)` method.
 */
enum LocationError {
  /**
   * The location services permission is currently not determined. Ask the user for location services authorization
   * via the `CLLocationManager`.
   *
   * Blippit will continue on its own after the permission is granted.
   */
  case notDetermined

  /**
   * The location services permission is denied. Ask the user to enable location services in the Settings app.
   *
   * Blippit will continue on its own after the permission is granted.
   */
  case denied

  /**
   * The location services permission is restricted. This usually happens when privacy restrictions are set on the
   * location services via the Settings app.
   *
   * Blippit will continue on its own after the restrictions are lifted.
   */
  case restricted
}

extension LocationError: Error {}
