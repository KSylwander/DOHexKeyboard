//
//  DefaultWaitForPodStateFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-06-17.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

struct DefaultWaitForPodStateFactory {}

extension DefaultWaitForPodStateFactory: WaitForPodStateFactory {
  func makeState(delegate: StateDelegate) -> State {
    return WaitForPodState(delegate: delegate)
  }
}
