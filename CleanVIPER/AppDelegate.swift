//
//  AppDelegate.swift
//  CleanVIPER
//
//  Created by Hiệp Hoàng on 26/05/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let configs = DefaultConfiguration(ContainerConfiguration())
        configs.configure()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = ListContactRoute.createListContactModule()
        
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

