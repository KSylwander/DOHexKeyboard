//
//  PodStateObserving.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

/* Conforming states can be notified of pod state changes */
protocol PodStateObserving: AnyObject {
  func handleState(_ state: PodState, for pod: Pod)
}
