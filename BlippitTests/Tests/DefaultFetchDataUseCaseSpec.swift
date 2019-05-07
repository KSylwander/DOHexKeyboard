//
//  DefaultFetchDataUseCaseSpec.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-06.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
import Quick

@testable import Blippit

final class DefaultFetchDataUseCaseSpec: QuickSpec {
  override func spec() {
    describe("the DefaultFetchDataUseCase") {
      let dataTask = MockableURLSessionDataTaskStub()
      let dataTaskFactory = MockDataTaskFactory()

      let sut = DefaultFetchDataUseCase(dataTaskFactory: dataTaskFactory)

      afterEach {
        reset(dataTaskFactory)
      }

      /* TODO: Implement me */
    }
  }
}
