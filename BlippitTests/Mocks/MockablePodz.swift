//
//  MockablePodz.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Podz

protocol MockablePodz: Podz {
  var status: PodzStatus { get }

  func start()
  func stop()

  var onPodFound: ((Pod) -> Void)? { get set }
  var onPodLost: ((Pod) -> Void)? { get set }
  var onStatusChanged: ((PodzStatus) -> Void)? { get set }
}
