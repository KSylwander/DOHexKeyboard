//
//  DefaultPodzStatusObservingStateSpec.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
import Nimble
import Podz
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
        it("cancels itself when Podz is \(status)") {
          /* Arrange */
          var thatSutWasCancelled = false
          stub(sut) { stub in
            when(stub.cancel()).then {
              thatSutWasCancelled = true
            }
          }

          /* Act */
          sut.handleStatus(status, for: podz)

          /* Assert */
          expect(thatSutWasCancelled).to(beTrue())
        }

        it("fails with corresponding error when Podz is \(status)") {
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
          expect(theError).notTo(beNil())
          expect(theError).to(equal(BlippitError.invalidPodzStatus(status)))
        }
      }

      let validStates: [PodzStatus] = [
        .running,
        .idle
      ]
      validStates.forEach { status in
        it("handles valid Podz \(status) state") {
          /* Arrange */
          var theStatus: PodzStatus?
          stub(sut) { stub in
            when(stub.handleValidStatus(any(), for: any())).then { status, _ in
              theStatus = status
            }
          }

          /* Act */
          sut.handleStatus(status, for: podz)

          /* Assert */
          expect(theStatus).toNot(beNil())
          expect(theStatus).to(equal(status))
        }
      }
    }
  }
}
