//
//  Constants.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-08.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import os.log

private final class Placeholder: NSObject {}

enum Constants {
  static let log = OSLog(
    subsystem: Bundle(for: Placeholder.self).bundleIdentifier!,
    // TODO: Replace placeholder with Blippit artifact
    category: String(describing: Blippit.self)
  )
}
