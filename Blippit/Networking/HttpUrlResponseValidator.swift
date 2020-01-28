//
//  HttpUrlResponseValidator.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

protocol HttpUrlResponseValidator {
  func validate(_ response: HTTPURLResponse, data: Data?) -> Error?
}
