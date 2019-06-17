//
//  WaitForPodStateFactory.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-06-17.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol WaitForPodStateFactory {
  func makeState(delegate: StateDelegate) -> State
}
