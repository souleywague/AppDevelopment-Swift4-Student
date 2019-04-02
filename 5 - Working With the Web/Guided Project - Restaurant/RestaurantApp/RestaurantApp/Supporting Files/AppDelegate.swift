//
//  AppDelegate.swift
//  RestaurantApp
//
//  Created by Souley on 27/01/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let temporaryDirectory = NSTemporaryDirectory()
        let urlCache = URLCache(memoryCapacity: 25_000_000, diskCapacity: 50_000_000, diskPath: temporaryDirectory)
        URLCache.shared = urlCache
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white 
        
        let categoriesViewController = CategoriesViewController()
        let yourOrderViewController = OrderViewController()
        
        let restaurantTabBarController: UITabBarController = {
            let tabBarController = UITabBarController()
            
            tabBarController.viewControllers = [categoriesViewController, yourOrderViewController].map {
                UINavigationController(rootViewController: $0)
            }
            
            categoriesViewController.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(named: "B"), selectedImage: UIImage(named: "B Selected"))
            yourOrderViewController.tabBarItem = UITabBarItem(title: "Your Order", image: UIImage(named: "O"), selectedImage: UIImage(named: "O Selected"))
            
            return tabBarController
        }()
        
        window?.rootViewController = restaurantTabBarController
        window?.makeKeyAndVisible()
        
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

