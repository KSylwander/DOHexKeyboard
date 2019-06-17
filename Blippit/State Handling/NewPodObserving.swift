//
//  NewPodObservingState.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-06-17.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

/* Conforming states can be notified of new pods */
protocol NewPodObserving: AnyObject {
  func handleNewPod(_ pod: Pod)
}
