//
//  EbsTest.swift
//  EbsTest
//
//  Created by Oneest on 8/18/18.
//  Copyright © 2018 Oneest. All rights reserved.
//

import UIKit

@UIApplicationMain
final class EbsTest: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    static var shared: EbsTest {
        if let model = UIApplication.shared.delegate as? EbsTest {
            return model
        } else {
            fatalError("EbsTest is not a application delegate")
        }
    }
    
    var reachabilitySwift: ReachabilitySwift {
        guard let reach = ReachabilitySwift(hostname: "http://8.8.8.8") else {
            fatalError("Cannot init ReachabilitySwift")
        }
        
        do {
            try reach.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        return reach
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = .lightContent
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
        reachabilitySwift.stopNotifier()
    }
}
