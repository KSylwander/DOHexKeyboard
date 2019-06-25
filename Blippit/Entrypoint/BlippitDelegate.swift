//
//  BlippitDelegate.swift
//  Blippit
//
//  Created by Jerson Perpetua on 2019-05-16.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Foundation

public protocol BlippitDelegate: AnyObject {
  func blippit(_ blippit: Blippit, didChangeState state: BlippitState)
  func blippit(_ blippit: Blippit, didFailWithError error: Error)
}
