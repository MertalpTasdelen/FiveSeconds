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
        let bundlePath = Bundle.main.path(forResource: "default", ofType: ".realm")
        let destPath = Realm.Configuration.defaultConfiguration.fileURL?.path
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: destPath!) {
            //File exist, do nothing
//            print(fileManager.fileExists(atPath: destPath!))
        } else {
            do {
                //Copy file from bundle to Realm default path
                try fileManager.copyItem(atPath: bundlePath!, toPath: destPath!)
            } catch {
                print("\n",error)
            }
        }
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {}
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
//        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

