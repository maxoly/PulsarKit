//
//  AppDelegate.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 10/08/2018.
//  Copyright © 2018 Nacoon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .secondary
        UINavigationBar.appearance().tintColor = .light
        
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.light]
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().largeTitleTextAttributes = attributes
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
        window?.makeKeyAndVisible()
        
        return true
    }
}

