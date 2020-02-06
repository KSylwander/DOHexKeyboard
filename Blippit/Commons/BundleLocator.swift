////
//  BundleLocator
//  BlippitKit
//
//  Copyright © 2020 Crunchfish Proximity AB. All rights reserved.
//

import Foundation

/* Can be used to locate the framework bundle either statically (i.e. `Bundle(for: BundleLocator.self`) from within
 * BlippitKit, or dynamically (i.e. `Bundle(for: NSClassFromString("BlippitKit.BundleLocator")!)`) from the client.
 */
@objc final class BundleLocator: NSObject {}
