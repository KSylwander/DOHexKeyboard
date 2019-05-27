//
//  State.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-07.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

protocol State: AnyObject {}

extension State {
  var name: String {
    return String(describing: type(of: self))
  }
}
