//
//  StartingStateSpec.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-08.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
import Nimble
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

      it("starts Podz when started") {
        /* Arrange */
        var thatPodzWasStarted = false
        stub(podz) { stub in
          when(stub.start()).then {
            thatPodzWasStarted = true
          }

          when(stub.status.get).thenReturn(.idle)
        }

        /* Act */
        sut.start()

        /* Assert */
        expect(thatPodzWasStarted).to(beTrue())
      }

      it("transitions to started state when Podz is running") {
        /* Arrange */
        var theNextState: RawState?
        stub(stateDelegate) { stub in
          when(stub.state(any(), moveTo: any())).then { _, nextState in
            theNextState = nextState
          }
        }

        /* Act */
        sut.handleStatus(.running, for: podz)

        /* Assert */
        expect(theNextState).notTo(beNil())
        expect(theNextState).to(equal(.started))
      }
    }
  }
}
