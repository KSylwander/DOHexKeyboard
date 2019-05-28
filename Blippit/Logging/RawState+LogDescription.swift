//
//  RawState+LogDescription.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-27.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

extension RawState {
  var logDescription: String {
    return String(String(describing: self).prefix(while: { $0 != "(" }))
  }
}
