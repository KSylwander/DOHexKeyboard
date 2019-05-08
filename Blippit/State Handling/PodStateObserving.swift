//
//  PodStateObserving.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-08.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

/* Conforming states can be notified of pod state changes */
protocol PodStateObserving: AnyObject {
  func handleState(_ state: PodState, for pod: Pod)
}
