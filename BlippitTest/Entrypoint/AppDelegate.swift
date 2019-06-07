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

    let window = self.window!
    window.rootViewController = MainViewController.instantiate(
      blippitFactory: DefaultBlippitFactory(
        podzApiKey: UUID(uuidString: "CF2A0178-E4BD-47F9-A508-4E50F4113BAD")!,
        podzAppId: UUID(uuidString: "CF000000-0000-0000-0000-000000000004")!,
        blippitApiKey: UUID(uuidString: "a6d9a801-752b-433f-b0e9-19b7c290afcd")!,
        blippitAppId: UUID(uuidString: "CF000000-0000-0000-0000-000000000004")!
      )
    )
    window.makeKeyAndVisible()

    return true
  }
}
