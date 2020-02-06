//
//  PodSessionStateObserving.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

/* Conforming states can be notified of pod session state changes */
protocol PodSessionStateObserving: AnyObject {
  func handleState(_ state: PodSessionState, for session: PodSession)
}
