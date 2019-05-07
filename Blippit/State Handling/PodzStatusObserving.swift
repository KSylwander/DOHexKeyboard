//
//  PodzStatusObserving.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

/* Conforming states can be notified of Podz status changes */
protocol PodzStatusObserving: AnyObject {
  func handleStatus(_ status: PodzStatus, for podz: Podz)
}
