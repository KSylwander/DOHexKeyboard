//
//  MockableDefaultPodzStatusObservingState.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

@testable import Blippit

protocol MockableDefaultPodzStatusObservingState:
  DefaultPodzStatusObservingState, Cancellable, ValidPodzStatusObserving {}
