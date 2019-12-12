//
//  AppDelegate.swift
//  PuzzleR
//
//  Created by Romeel Chaudhari on 11/15/19.
//  Copyright © 2019 Romeel Chaudhari. All rights reserved.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {      //inheritance superclasses
    

    
    var win: UIWindow?  //Nil-Coalescing Operator

//Launch
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.win = UIWindow(frame: UIScreen.main.bounds)
        if let win = self.win {
            win.backgroundColor = UIColor.black
            
            let nav1 = UINavigationController()
            let View = ViewController()
            nav1.viewControllers = [View]
            win.rootViewController = nav1         //The root view controller provides the content view of the window. Assigning a view controller to this property (either programmatically or using Interface Builder) installs the view controller’s view as the content view of the window.
            win.makeKeyAndVisible()
        }
        sleep(2);
        return true
        }
     // needful functions stackoverflow.

    //In iOS, a delegate is a class that does something on behalf of another class, and the AppDelegate is a place to handle special UIApplication states. It has a bunch of functions called by iOS.
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

