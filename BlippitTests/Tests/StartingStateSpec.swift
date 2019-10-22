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
        stub(podz) { stub in
          when(stub.status.get).thenReturn(.idle)
        }

        /* Act */
        sut.start()

        /* Assert */
        verify(podz).start()
      }

      it("transitions to the next state when Podz is running") {
        /* Arrange */
        var thePreviousState: PreviousState?
        stub(stateDelegate) { stub in
          when(stub.state(any(), moveFrom: any())).then { _, previousState in
            thePreviousState = previousState
          }
        }

        /* Act */
        sut.handleStatus(.running, for: podz)

        /* Assert */
        expect(thePreviousState).toNot(beNil())
        expect(thePreviousState).to(equal(.starting))
      }
    }
  }
}
