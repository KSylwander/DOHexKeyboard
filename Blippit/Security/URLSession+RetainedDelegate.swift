//
//  URLSession+RetainedDelegate.swift
//  BlippitKit
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

extension URLSession {
  private enum Keys {
    static var retainedDelegate = UInt8(0)
  }

  convenience init(configuration: URLSessionConfiguration, retainedDelegate: URLSessionDelegate) {
    self.init(configuration: configuration, delegate: retainedDelegate, delegateQueue: nil)
    objc_setAssociatedObject(self, &Keys.retainedDelegate, retainedDelegate, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
}
