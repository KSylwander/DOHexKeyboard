//
//  DefaultWaitForPodStateFactory.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

struct DefaultWaitForPodStateFactory {}

extension DefaultWaitForPodStateFactory: WaitForPodStateFactory {
  func makeState(delegate: StateDelegate) -> State {
    return WaitForPodState(delegate: delegate)
  }
}
