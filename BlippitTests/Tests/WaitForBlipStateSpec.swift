//
//  WaitForBlipStateSpec.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-08.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
import Nimble
import Podz
import Quick

@testable import Blippit

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

        it("opens session on blip") {
          /* Act */
          sut.handleState(.blip(session: session), for: pod)

          /* Assert */
          verify(session).open()
        }

        it("fails on session open error") {
          /* Arrange */
          stub(session) { stub in
            when(stub.open()).thenThrow(any())
          }

          /* Act */
          sut.handleState(.blip(session: session), for: pod)

          /* Assert */
          verify(stateDelegate).state(any(), didFailWithError: any())
        }
      }

      it("transitions to the cancel state when cancelled") {
        /* Arrange */
        var thePreviousState: PreviousState?
        stub(stateDelegate) { stub in
          when(stub.state(any(), moveFrom: any())).then { _, previousState in
            thePreviousState = previousState
          }
        }

        /* Act */
        sut.cancel()

        /* Assert */
        expect(thePreviousState).toNot(beNil())
        expect(thePreviousState).to(equal(.cancelling))
      }

      it("ignores multiple cancels") {
        /* Act */
        sut.cancel()
        sut.cancel()
        sut.cancel()

        /* Assert */
        verify(stateDelegate, times(1)).state(any(), moveFrom: any())
      }
    }
  }
}
