//
//  KeyboardHandlerFactory
//  BlippitKit
//
//  Copyright © 2020 Crunchfish Proximity AB. All rights reserved.
//

import UIKit

protocol KeyboardHandlerFactory {
  func makeKeyboardHandler(scrollView: UIScrollView) -> KeyboardHandling
}
