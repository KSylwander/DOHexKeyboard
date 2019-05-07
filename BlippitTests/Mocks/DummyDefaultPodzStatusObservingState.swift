//
//  DummyDefaultPodzStatusObservingState.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

@testable import Blippit

/* Allows the `DefaultPodzStatusObservingState` mix-in to be spied on via its various requirements (i.e.,
 * `Cancellable`, `ValidPodzStatusObserving`, and its delegate). See `Mocks.generated.swift` for the
 * generated mock.
 */
protocol DummyDefaultPodzStatusObservingState:
  DefaultPodzStatusObservingState, Cancellable, ValidPodzStatusObserving {}
