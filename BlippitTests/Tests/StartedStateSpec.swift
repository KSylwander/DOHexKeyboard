//
//  StartedStateSpec.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-08.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
import Quick

@testable import Blippit

final class StartedStateSpec: QuickSpec {
  override func spec() {
    describe("the started state") {
      let stateDelegate = MockStateDelegate().withEnabledDefaultImplementation(StateDelegateStub())

      var sut = StartedState(delegate: stateDelegate)

      afterEach {
        reset(stateDelegate)
        sut = StartedState(delegate: stateDelegate)
      }

      // TODO: Implement me
    }
  }
}
