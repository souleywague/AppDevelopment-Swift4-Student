//
//  AppDelegate.swift
//  AppLifeCycle
//
//  Created by Souley on 18/12/2018.
//  Copyright © 2018 Souley. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("Did finish launching.")
        print("Did become active")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print("Will resign active.")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("Did enter background.")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("Will enter foreground.")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("Did become active")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("Will terminate")
    }


}

