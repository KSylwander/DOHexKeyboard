//
//  DummyPod.swift
//  BlippitTests
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

/* Allows `Pod`to be mocked from within this project. See `Mocks.generated.swift` for the generated mock. */
protocol DummyPod: Pod {
  var pid: UInt32 { get }

  var state: PodState { get }

  var onStateChanged: ((Pod, PodState) -> Void)? { get set }
}
