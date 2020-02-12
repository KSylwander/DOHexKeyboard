//
//  DummyPodSession.swift
//  BlippitTests
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import PodzKit

/* Allows `PodSession` to be mocked from within this project. See `Mocks.generated.swift` for the generated mock. */
protocol DummyPodSession: PodSession {
  var state: PodSessionState { get }

  var onSessionStateChanged: ((PodSession, PodSessionState) -> Void)? { get set }

  func open() throws
  func close() throws

  func availableTransactions() throws -> [TransactionType]
  func perform(transaction: Transaction) throws
}
