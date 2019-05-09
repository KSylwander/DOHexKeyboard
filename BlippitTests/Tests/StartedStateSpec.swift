//
//  StartedStateSpec.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-08.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
import Podz
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
      }
    }
  }
}
