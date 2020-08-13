//
//  AppDelegate.swift
//  NavigationInterfaceExam
//
//  Created by ggyool on 2020/08/12.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: "RootVC")
//        self.window?.rootViewController = initialViewController
        
//        let rootViewController = UIViewController()
//        print("AppDelegate: ", rootViewController)
//        let navigationController = UINavigationController(rootViewController: rootViewController)
//        print("delegate: ", navigationController)
//        navigationController.title = "제목"
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.rootViewController = navigationController
//        self.window?.makeKeyAndVisible()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

