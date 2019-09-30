//
//  AppDelegate.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 29/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import SharedComponents

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var services: [ApplicationService] = [
      NetworkService.safeSession,
      NetworkService.cachedSession,
      AppearanceService()
    ]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
      var result = true

      services.forEach {
        if let res = $0.application?(application, didFinishLaunchingWithOptions: launchOptions), !res {
          result = false
        }
      }
      return result
    }
  
  // MARK: UISceneSession Lifecycle

//  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//  }
//
//  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//  }

}

