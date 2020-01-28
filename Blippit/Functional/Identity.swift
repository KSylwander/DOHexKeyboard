//
//  Identity.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

/* Adapted from https://github.com/jspahrsummers/RxSwift/blob/master/RxSwift/Identity.swift */

/* The identity function, which returns its argument.
 *
 * This can be used to prove to the typechecker that a given type A is equivalent to a given type B.
 */
func identity<T>(_ value: T) -> T {
  return value
}
