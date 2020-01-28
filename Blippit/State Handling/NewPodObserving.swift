//
//  NewPodObservingState.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

/* Conforming states can be notified of new pods */
protocol NewPodObserving: AnyObject {
  func handleNewPod(_ pod: Pod)
}
