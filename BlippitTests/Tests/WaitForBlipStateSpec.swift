//
//  WaitForBlipStateSpec.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-08.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
import Nimble
import PodzKit
import Quick

@testable import BlippitKit

final class WaitForBlipStateSpec: QuickSpec {
  override func spec() {
    describe("the wait-for-blip state") {
      let stateDelegate = MockStateDelegate().withEnabledDefaultImplementation(StateDelegateStub())

      var sut = WaitForBlipState(delegate: stateDelegate)

      afterEach {
        reset(stateDelegate)
        sut = WaitForBlipState(delegate: stateDelegate)
      }

      context("when handling pod states") {
        let pod = DummyPodStub()
        let session = MockDummyPodSession().withEnabledDefaultImplementation(DummyPodSessionStub())

        afterEach {
          reset(session)
        }

        let nonBlipStates: [PodState] = [
          .far,
          .close,
          .unknown
        ]
        nonBlipStates.forEach { state in
          it("ignores \(state) state") {
            /* Act */
            sut.handleState(state, for: pod)

            /* Assert */
            verifyNoMoreInteractions(stateDelegate)
            verifyNoMoreInteractions(session)
          }
        }
      }

      it("transitions to the cancel state when cancelled") {
        /* Arrange */
        var theStateTransition: StateTransition?
        stub(stateDelegate) { stub in
          when(stub.move(to: any())).then { stateTransition in
            theStateTransition = stateTransition
          }
        }

        /* Act */
        sut.cancel()

        /* Assert */
        expect(theStateTransition).toNot(beNil())
        expect(theStateTransition).to(equal(.cancelled(from: sut)))
      }

      it("ignores multiple cancels") {
        /* Act */
        sut.cancel()
        sut.cancel()
        sut.cancel()

        /* Assert */
        verify(stateDelegate, times(1)).move(to: any())
      }
    }
  }
}
