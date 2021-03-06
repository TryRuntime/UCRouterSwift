//
//  AppDelegate.swift
//  UCRouterSwift
//
//  Created by Link913 on 04/29/2019.
//  Copyright (c) 2019 Link913. All rights reserved.
//

import UIKit
import UCRouterSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let sb = UIStoryboard(name: "Main", bundle: .main)
        let vc = sb.instantiateViewController(withIdentifier: "vc")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = .white
        window!.rootViewController = UINavigationController(rootViewController: vc)
        window!.makeKeyAndVisible()
        
        // 设置导航以及过滤实现
        UCRouter.default.setNavgationAndFilter(navgation: NavgationDelegate(), filter: FilterDelegate())
        // 注册
        UCRouter.default.registProtoclAndModule(UCRouterKey<ModuleAProtocol>(), ModuleA.self)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

