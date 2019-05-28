//
//  URLSession+RetainedDelegate.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-22.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

extension URLSession {
  private enum keys {
    static var retainedDelegate = UInt8(0)
  }

  convenience init(configuration: URLSessionConfiguration, retainedDelegate: URLSessionDelegate) {
    self.init(configuration: configuration, delegate: retainedDelegate, delegateQueue: nil)
    objc_setAssociatedObject(self, &keys.retainedDelegate, retainedDelegate, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
}
