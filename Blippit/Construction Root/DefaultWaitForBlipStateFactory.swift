//
//  DefaultWaitForBlipStateFactory.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

struct DefaultWaitForBlipStateFactory {}

extension DefaultWaitForBlipStateFactory: WaitForBlipStateFactory {
  func makeState(delegate: StateDelegate) -> State {
    return WaitForBlipState(delegate: delegate)
  }
}
