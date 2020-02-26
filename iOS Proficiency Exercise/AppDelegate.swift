//
//  AppDelegate.swift
//  iOS Proficiency Exercise
//
//  Created by Nanda iMac on 25/02/20.
//  Copyright © 2020 Nanda. All rights reserved.
//
//ssa
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // set root view controller as HomeController
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let rootNavigationVC = UINavigationController(rootViewController: HomeController())
        if #available(iOS 11.0, *) {
            rootNavigationVC.navigationBar.prefersLargeTitles = true
        }else{
            rootNavigationVC.navigationBar.prefersLargeTitles = false
        }
        window?.rootViewController = rootNavigationVC

        return true
    }


}

