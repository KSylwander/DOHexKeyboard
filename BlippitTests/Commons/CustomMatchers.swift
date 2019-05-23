//
//  CustomMatchers.swift
//  BlippitTests
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Nimble

func beASuccess<V, E>() -> Predicate<Result<V, E>> {
  return Predicate.define("succeed") { actualExpression, message in
    switch try actualExpression.evaluate() {
    case nil:
      return PredicateResult(status: .fail, message: message)
    case let result?:
      return PredicateResult(bool: result.isSuccess, message: message)
    }
  }
}

func equal<V: Equatable, E>(_ expectedValue: V?) -> Predicate<Result<V, E>> {
  return Predicate.define("equal <\(String(describing: expectedValue))") { actualExpression, message in
    let actualValue = try actualExpression.evaluate()
    switch (expectedValue, actualValue) {
    case (nil, _?):
      return PredicateResult(status: .fail, message: message.appendedBeNilHint())
    case (_, nil), (_, .failure?):
      return PredicateResult(status: .fail, message: message)
    case (let expectedValue?, .success(let actualValue)?):
      return PredicateResult(bool: expectedValue == actualValue, message: message)
    }
  }
}
