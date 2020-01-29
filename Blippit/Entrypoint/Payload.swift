//
//  Payload.swift
//  BlippitKit
//
//  Copyright © 2020 Crunchfish Proximity AB. All rights reserved.
//

import Foundation
import PodzKit

/**
 * Payload that are transfered upon a blip with an App Terminal.
 */
public struct Payload {

  /**
   * The value of the payload.
   */
  public var value: String {
    return transferId.idString
  }

  let transferId: TransferId

  /**
   * Instantiate a payload.
   *
   * - parameter value: The payload string passed here must be alphanumeric
   *                    (i.e., `[a-zA-Z0-9]{1,128}`).
   * - throws: `PayloadError` if the value is not alphanumeric or has the incorrect size.
   */
  public init(value: String) throws {
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
