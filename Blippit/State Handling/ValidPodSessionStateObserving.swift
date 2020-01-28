//
//  ValidPodSessionStateObserving.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

/* Conforming states can be notified of pod session state changes if the latter is valid, and the state also conforms to
 * `DefaultPodSessionStateObservingState`
 */
protocol ValidPodSessionStateObserving: AnyObject {
  func handleValidState(_ state: PodSessionState, for session: PodSession)
}
