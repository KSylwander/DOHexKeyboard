//
//  BlippitDelegate.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

public protocol BlippitDelegate: AnyObject {
  func blippitWillStart(_ blippit: Blippit)
  func blippitDidStart(_ blippit: Blippit)
  func blippitDidStop(_ blippit: Blippit)

  func blippit(_ blippit: Blippit, didFailWithError error: Error)
}
