//
//  AppDelegate.swift
//  Song Studio
//
//  Created by Prakhar Tripathi on 31/10/19.
//  Copyright © 2019 Prakhar Tripathi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func openMainScreen() {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let controller = storyboard.instantiateViewController(withIdentifier: "HomeViewController_ID")
         let navController = UINavigationController()
         navController.navigationBar.isHidden = true
         navController.viewControllers = [controller]
         self.window?.rootViewController = navController
     }
}

