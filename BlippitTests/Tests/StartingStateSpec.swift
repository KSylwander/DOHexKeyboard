//
//  StartingStateSpec.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-08.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
import Quick

@testable import Blippit

final class StartingStateSpec: QuickSpec {
  override func spec() {
    describe("the starting state") {
      let stateDelegate = MockStateDelegate().withEnabledDefaultImplementation(StateDelegateStub())
      let podz = MockDummyPodz().withEnabledDefaultImplementation(DummyPodzStub())

      let sut = StartingState(delegate: stateDelegate, podz: podz)

      afterEach {
        reset(stateDelegate, podz)
      }

      // TODO: Implement me
    }
  }
}
