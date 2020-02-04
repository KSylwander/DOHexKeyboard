//
//  AppDelegate.swift
//  BlippitTest
//
//  Created by Jerson Perpetua on 2019-05-24.
//  Copyright © 2019 Crunchfish AB. All rights reserved.
//

import BlippitKit
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
      blippitFactory: DefaultBlippitFactory()
    )
    window.makeKeyAndVisible()

    return true
  }
}
