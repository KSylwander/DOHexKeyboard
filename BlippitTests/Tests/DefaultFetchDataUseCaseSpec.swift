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
        onDataTask { _, completion in
          /* Complete with an error */
          completion(nil, immaterial(), any())
          return dataTask
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

      it("returns the data on success") {
        /* Arrange */
        let expectedData: Data = any()
        onDataTask { _, completion in
          /* Complete with data */
          completion(expectedData, immaterial(), nil)
          return dataTask
        }

        /* Act */
        var theResult: Result<Data, Error>?
        sut.fetchData(with: immaterial()) { _, result in
          theResult = result
        }

        /* Assert */
        expect(theResult).notTo(beNil())
        expect(theResult).to(equal(expectedData))
      }

      typealias DataTaskCompletion = (Data?, URLResponse?, Error?) -> Void
      typealias DataTaskMethod = (URLRequest, @escaping DataTaskCompletion) -> URLSessionDataTask

      func onDataTask(_ implementation: @escaping DataTaskMethod) {
        stub(dataTaskFactory) { stub in
          when(stub.dataTask(with: any(), completionHandler: any())).then(implementation)
        }
      }
    }
  }
}
