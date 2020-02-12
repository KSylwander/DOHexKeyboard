//
//  AppDelegate.swift
//  BlippitTest
//
//  Copyright © 2019 Crunchfish Proximity AB. All rights reserved.
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
    window.rootViewController = MainViewController.instantiate()
    window.makeKeyAndVisible()

    return true
  }
}
