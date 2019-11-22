//
//  DefaultPodzStatusObservingStateSpec.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
import Nimble
import PodzKit
import Quick

@testable import BlippitKit

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
          /* Act */
          sut.handleStatus(status, for: podz)

          /* Assert */
          verify(sut).cancel()
        }
      }

      let validStates: [PodzStatus] = [
        .running,
        .idle
      ]
      validStates.forEach { status in
        it("does nothing when Podz is \(status)") {
          /* Act */
          sut.handleStatus(status, for: podz)

          /* Assert */
          verifyNoMoreInteractions(sut)
        }
      }
    }
  }
}
