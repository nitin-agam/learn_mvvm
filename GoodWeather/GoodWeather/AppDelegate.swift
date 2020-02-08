//
//  AppDelegate.swift
//  GoodWeather
//
//  Created by Nitin A on 25/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static let kAppColor = UIColor(red: 0/255, green: 163/255, blue: 204/255, alpha: 1)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNavigationBar()
        setupDefaultSettings()
        return true
    }
    
    private func setupDefaultSettings() {
        let userDefault = UserDefaults.standard
        if userDefault.value(forKey: "unit") == nil {
            userDefault.set(Unit.celsius.rawValue, forKey: "unit")
        }
    }
    
    private func setupNavigationBar() {
        // setup for navigation bar
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = AppDelegate.kAppColor
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = .white
            UINavigationBar.appearance().barTintColor = AppDelegate.kAppColor
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
}

