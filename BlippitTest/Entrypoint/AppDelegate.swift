//
//  AppDelegate.swift
//  BlippitTest
//
//  Created by Jerson Perpetua on 2019-05-24.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import Blippit
import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder {
  lazy var window: UIWindow? = UIWindow()
}

extension AppDelegate: UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

#if PRODUCTION
    let blippitApiKey = UUID(uuidString: "66A69E05-3750-41FE-8C08-8A57D9F7CBAD")!
#elseif STAGE
    let blippitApiKey = UUID(uuidString: "a6d9a801-752b-433f-b0e9-19b7c290afcd")!
#else
    let blippitApiKey = UUID(uuidString: "d48a1a59-8b39-4a83-8355-fb2712b2d53f")!
#endif

    let window = self.window!
    window.rootViewController = MainViewController.instantiate(
      blippitFactory: DefaultBlippitFactory(
        blippitApiKey: blippitApiKey,
        blippitAppId: UUID(uuidString: "CF000000-0000-0000-0000-000000000004")!
      )
    )
    window.makeKeyAndVisible()

    return true
  }
}
