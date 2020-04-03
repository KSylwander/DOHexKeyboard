//
//  PayloadSpec
//  BlippitKit
//
//  Copyright © 2020 Crunchfish Proximity AB. All rights reserved.
//

import Cuckoo
import Nimble
import PodzKit
import Quick

@testable import BlippitKit

final class PayloadSpec: QuickSpec {
  override func spec() {
    describe("a payload") {
      it("is not too short") {
        expect { _ = try Payload(containing: "") }.to(throwError(PayloadError.invalidLength))
      }

      it("is not too long") {
        expect { _ = try Payload(containing: String(repeating: "a", count: 129)) }.to(
          throwError(PayloadError.invalidLength)
        )
      }

      it("does not accept non-ASCII characters") {
        expect { _ = try Payload(containing: "adb4中fdq21") }.to(throwError(PayloadError.invalidFormat))
      }

      it("does not accept non-alphanumeric ASCII characters") {
        expect { _ = try Payload(containing: "adb4,fdq21") }.to(throwError(PayloadError.invalidFormat))
      }

      it("accepts numeric ASCII characters") {
        expect { _ = try Payload(containing: "421") }.toNot(throwError(PayloadError.invalidFormat))
      }

      it("accepts alphabetic ASCII characters") {
        expect { _ = try Payload(containing: "adbfdq") }.toNot(throwError(PayloadError.invalidFormat))
      }

      it("accepts alphanumeric ASCII characters") {
        expect { _ = try Payload(containing: "adb4fdq21") }.toNot(throwError(PayloadError.invalidFormat))
      }
    }
  }
}
