//
//  DefaultPodzStatusObservingStateSpec.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
import Nimble
import Quick

@testable import Blippit

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

      it("stops Podz when the latter is locked") {
        /* Arrange */
        var thatPodzWasStopped = false
        stub(podz) { stub in
          when(stub.stop()).then {
            thatPodzWasStopped = true
          }
        }

        /* Act */
        sut.handleStatus(.locked, for: podz)

        /* Assert */
        expect(thatPodzWasStopped).to(beTrue())
      }
    }
  }
}
