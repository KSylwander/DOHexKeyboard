//
//  PodSessionStateObserving.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-15.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import PodzKit

/* Conforming states can be notified of pod session state changes */
protocol PodSessionStateObserving: AnyObject {
  func handleState(_ state: PodSessionState, for session: PodSession)
}
