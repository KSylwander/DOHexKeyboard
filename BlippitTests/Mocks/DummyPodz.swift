//
//  DummyPodz.swift
//  BlippitTests
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

/* Allows `Podz` to be mocked from within this project. See `Mocks.generated.swift` for the generated mock. */
protocol DummyPodz: Podz {
  var status: PodzStatus { get }

  func start()
  func stop()

  var onPodFound: ((Pod) -> Void)? { get set }
  var onPodLost: ((Pod) -> Void)? { get set }
  var onStatusChanged: ((PodzStatus) -> Void)? { get set }
}
