//
//  LostPodObserving.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

/* Conforming state can be notified of lost pods */
protocol LostPodObserving: AnyObject {
  func handleLostPod(_ pod: Pod)
}
