//
//  BlippitState+LogDescription
//  BlippitKit
//
//  Copyright © 2020 Crunchfish Proximity AB. All rights reserved.
//

import BlippitKit

extension BlippitState {
  var logDescription: String {
    return String(reflecting: self)
  }
}
