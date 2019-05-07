//
//  DefaultFetchDataUseCaseSpec.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-06.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Cuckoo
import Nimble
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

      it("fails on error") {
        /* Arrange */
        stub(dataTaskFactory) { stub in
          when(stub.dataTask(with: any(), completionHandler: any())).then { _, completion in
            /* Complete with an error */
            completion(nil, immaterial(), any())
            return dataTask
          }
        }

        /* Act */
        var theResult: Result<Data, Error>?
        sut.fetchData(with: immaterial()) { _, result in
          theResult = result
        }

        /* Assert */
        expect(theResult).notTo(beNil())
        expect(theResult).notTo(beASuccess())
      }
    }
  }
}
