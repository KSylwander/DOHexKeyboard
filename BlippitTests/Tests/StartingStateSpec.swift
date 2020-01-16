//
//  StartingStateSpec.swift
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

final class StartingStateSpec: QuickSpec {
  override func spec() {
    describe("the starting state") {
      let stateDelegate = MockStateDelegate().withEnabledDefaultImplementation(StateDelegateStub())
      let podz = MockDummyPodz().withEnabledDefaultImplementation(DummyPodzStub())

      let sut = StartingState(delegate: stateDelegate, podz: podz)

      afterEach {
        reset(stateDelegate, podz)
      }

      it("starts Podz when the latter is idle") {
        /* Arrange */
        stub(podz) { stub in
          when(stub.status.get).thenReturn(.idle)
        }

        /* Act */
        sut.start()

        /* Assert */
        verify(podz).start()
      }

      let invalidStates: [PodzStatus] = [
        .locked,
        .pending(error: .bluetoothOff),
        .pending(error: .bluetoothUnauthorized),
        .pending(error: .locationDenied),
        .pending(error: .locationNotDetermined),
        .pending(error: .locationRestricted),
        .pending(error: .internetNotAvailable)
      ]
      invalidStates.forEach { status in
        it("fails when Podz is \(status)") {
          /* Arrange */
          var theError: Error?
          stub(stateDelegate) { stub in
            when(stub.state(any(), didFailWithError: any())).then { _, error in
              theError = error
            }
          }

          /* Act */
          sut.handleStatus(status, for: podz)

          /* Assert */
          expect(theError).toNot(beNil())
        }
      }

      it("transitions to the next state when Podz is running") {
        /* Arrange */
        var theStateTransition: StateTransition?
        stub(stateDelegate) { stub in
          when(stub.move(to: any())).then { stateTransition in
            theStateTransition = stateTransition
          }
        }

        /* Act */
        sut.handleStatus(.running, for: podz)

        /* Assert */
        expect(theStateTransition).toNot(beNil())
        expect(theStateTransition).to(equal(.next(from: .starting)))
      }

      it("stops Podz when the latter is locked") {
        /* Act */
        sut.handleStatus(.locked, for: podz)

        /* Assert */
        verify(podz).stop()
      }
    }
  }
}
