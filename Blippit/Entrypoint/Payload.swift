//
//  Payload.swift
//  BlippitKit
//
//  Copyright © 2020 Crunchfish Proximity AB. All rights reserved.
//

import Foundation
import PodzKit

/**
 * Payload that is transferred on blip with an app terminal.
 */
public struct Payload: Equatable {

  let transferId: TransferId

  /**
   * Instantiate a payload.
   *
   * - parameter value: The payload string passed here must be alphanumeric
   *                    (i.e., `[a-zA-Z0-9]{1,128}`).
   * - throws: `PayloadError` if the value is not alphanumeric or has the incorrect size.
   */
  public init(containing value: String) throws {
    do {
      transferId = try TransferId(from: value)
    } catch {
      switch error {
      case IdError.invalidSize:
        throw PayloadError.invalidLength
      case IdError.invalidFormat:
        throw PayloadError.invalidFormat
      default:
        throw error
      }
    }
  }
}

extension Payload: LosslessStringConvertible {
  /**
   * Instantiates a payload from a string representation.
   */
  public init?(_ description: String) {
    do {
      try self.init(containing: description)
    } catch {
      return nil
    }
  }

  /**
   * A textual representation of this payload.
   */
  public var description: String {
    return transferId.idString
  }
}
