//
//  AppDelegate.swift
//  PuzzleR
//
//  Created by Romeel Chaudhari on 11/15/19.
//  Copyright © 2019 Romeel Chaudhari. All rights reserved.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    
    var win: UIWindow?

//Launch
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.win = UIWindow(frame: UIScreen.main.bounds)
        if let win = self.win {
            win.backgroundColor = UIColor.black
            
            let nav1 = UINavigationController()
            let View = ViewController()
            nav1.viewControllers = [View]
            win.rootViewController = nav1
            win.makeKeyAndVisible()
        }
        sleep(2);
        return true
        }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

