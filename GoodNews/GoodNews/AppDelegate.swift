//
//  AppDelegate.swift
//  GoodNews
//
//  Created by Nitin A on 16/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().barTintColor = .darkGray
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
        
//        let controller = HeadlinesController()
//        let navigation = UINavigationController(rootViewController: controller)
//        self.window?.rootViewController = navigation
//        self.window?.makeKeyAndVisible()
        return true
    }
}

