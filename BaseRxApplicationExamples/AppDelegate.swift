//
//  AppDelegate.swift
//  BaseRxApplicationExamples
//
//  Created by Gary Dos Santos on 2/3/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit
import BaseRxApplication
import CocoaLumberjack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        // INI: Remove when needed
        
        let nav = BaseNavigationController(rootViewController: UIViewController())
        nav.tabBarItem = UITabBarItem(title: "Gary", image: UIImage(named: "tab_car")?.tint(withColor: UIColor.black), selectedImage: UIImage(named: "tab_car")?.tint(withColor: UIColor.blue))
        
        let nav2 = BaseNavigationController(rootViewController: UIViewController())
        nav2.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(named: "tab_cart")?.tint(withColor: UIColor.black), selectedImage: UIImage(named: "tab_cart")?.tint(withColor: UIColor.blue))

        let nav3 = BaseNavigationController(rootViewController: UIViewController())
        nav3.tabBarItem = UITabBarItem(title: "Cuca2", image: UIImage(named: "tab_cart")?.tint(withColor: UIColor.black), selectedImage: UIImage(named: "tab_cart")?.tint(withColor: UIColor.blue))
        
        let tabBarController = ExampleTabBarController(height: 100.0, backgroundColor: UIColor.white)
        tabBarController.viewControllers  = [nav, nav2, nav3]
        
        tabBarController.perform(#selector(ExampleTabBarController.addProduct), with: nil, afterDelay: 5.0)
        tabBarController.perform(#selector(ExampleTabBarController.addProduct), with: nil, afterDelay: 15.0)
        tabBarController.perform(#selector(ExampleTabBarController.addProduct), with: nil, afterDelay: 25.0)
        
        // END
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        
        setupCocoaLumberJack()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
