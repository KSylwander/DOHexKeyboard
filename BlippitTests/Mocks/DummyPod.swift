//
//  DummyPod.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-08.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import PodzKit

/* Allows `Pod`to be mocked from within this project. See `Mocks.generated.swift` for the generated mock. */
protocol DummyPod: Pod {
  var pid: UInt32 { get }

  var state: PodState { get }

  var onStateChanged: ((Pod, PodState) -> Void)? { get set }
  var onUpdated: ((Pod, Date, Int, Int, Int) -> Void)? { get set }
}
