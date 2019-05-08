//
//  DefaultPodzStatusObservingStateSpec.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
import Quick

final class DefaultPodzStatusObservingStateSpec: QuickSpec {
  override func spec() {
    describe("the DefaultPodzStatusObservingState") {
      let stateDelegate = MockStateDelegate().withEnabledDefaultImplementation(StateDelegateStub())
      let podz = MockDummyPodz().withEnabledDefaultImplementation(DummyPodzStub())

      let sut = MockDummyDefaultPodzStatusObservingState()
        .withEnabledDefaultImplementation(DummyDefaultPodzStatusObservingStateStub())

      beforeEach {
        stub(sut) { stub in
          when(stub.delegate.get).thenReturn(stateDelegate)
        }
      }

      afterEach {
        reset(stateDelegate, podz, sut)
      }

      // TODO: Implement me
    }
  }
}
