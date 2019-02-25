//
//  AppDelegate.swift
//  FiveSeconds
//
//  Created by Mertalp Taşdelen on 20.06.2018.
//  Copyright © 2018 Mertalp Taşdelen. All rights reserved.
//

import UIKit
import ChameleonFramework
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        print(Realm.Configuration.defaultConfiguration.fileURL)  //For getting the path
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {}
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
//        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    
}

