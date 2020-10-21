//
//  AppDelegate.swift
//  nimble
//
//  Created by Chung Tran on 10/21/20.
//

import UIKit
@_exported import BEPureLayout

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        let loginVC = LoginViewController()
        self.window?.rootViewController = loginVC
        self.window?.makeKeyAndVisible()
        return true
    }

}

