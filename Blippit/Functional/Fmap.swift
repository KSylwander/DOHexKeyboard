//
//  Fmap.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

/* Adapted from https://github.com/typelift/Swiftx/blob/master/Sources/Swiftx/Optional.swift */

/* If the `Optional` is `.none`, ignores the function and returns `.none`. Else if the `Optional` is `.some`, applies
 * the function to its value and returns the result in a new `.some`.
 *
 * That is, `fmap(f, a)` = `a.map(f)`.
 */
func fmap<T, U>(_ f: (T) -> U, _ a: T?) -> U? {
  return a.map(f)
}
