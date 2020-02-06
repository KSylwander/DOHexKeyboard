//
//  DefaultKeyboardHandlerFactory
//  BlippitKit
//
//  Copyright © 2020 Crunchfish Proximity AB. All rights reserved.
//

import UIKit

struct DefaultKeyboardHandlerFactory {}

extension DefaultKeyboardHandlerFactory: KeyboardHandlerFactory {
  func makeKeyboardHandler(scrollView: UIScrollView) -> KeyboardHandling {
    return KeyboardHandler(scrollView: scrollView)
  }
}
