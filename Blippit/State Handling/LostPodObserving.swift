//
//  LostPodObserving.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-11-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import PodzKit

/* Conforming state can be notified of lost pods */
protocol LostPodObserving: AnyObject {
  func handleLostPod(_ pod: Pod)
}
