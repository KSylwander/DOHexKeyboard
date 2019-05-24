//
//  DummyURLSessionDataTask.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-06.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

/* Allows the `URLSessionDataTask` to be mocked from within this project. See `Mocks.generated.swift` for the
 * generated mock.
 */
class DummyURLSessionDataTask: URLSessionDataTask {
  override func resume() {
    super.resume()
  }
}
