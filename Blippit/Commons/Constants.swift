//
//  Constants.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-08.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import os.log

enum Constants {
  static let log = OSLog(
    subsystem: Bundle(for: DefaultBlippit.self).bundleIdentifier!,
    category: String(describing: Blippit.self)
  )

  static let dataTokenPrefix = "9959999"
}
