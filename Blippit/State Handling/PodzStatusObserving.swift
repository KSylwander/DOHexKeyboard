//
//  PodzStatusObserving.swift
//  Blippit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

/* Conforming states can be notified of Podz status changes */
protocol PodzStatusObserving: AnyObject {
  func handleStatus(_ status: PodzStatus, for podz: Podz)
}
