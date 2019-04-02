//
//  AppDelegate.swift
//  AppEventCount
//
//  Created by Souley on 18/12/2018.
//  Copyright © 2018 Souley. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var viewController: ViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        viewController = window?.rootViewController as? ViewController
        viewController?.launchCount += 1
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        viewController?.resignCount += 1
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        viewController?.enterBackgroundCount += 1
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        viewController?.enterForegroundCount += 1
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        viewController?.updateView()
        viewController?.becomeActiveCount += 1
    }

    func applicationWillTerminate(_ application: UIApplication) {
        viewController?.willTerminateCount += 1
    }
}

