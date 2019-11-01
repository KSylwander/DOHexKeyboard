//
//  BlippitMode.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-10-17.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

public enum BlippitMode {
  case payerId(String)
}

/* TODO: Remove when `.payment` is exposed publicly */
enum _BlippitMode {
  case payment(apiKey: UUID, appId: UUID, serviceInfo: ServiceInfo)
  case payerId(String)

  init(_ mode: BlippitMode) {
    switch mode {
    case let .payerId(value):
      self = .payerId(value)
    }
  }
}
