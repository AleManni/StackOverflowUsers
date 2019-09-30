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

    var window: UIWindow?

    private var services: [ApplicationService] = [
      NetworkService.safeSession,
      NetworkService.cachedSession,
      AppearanceService(),
      AppCoordinatorService()
    ]

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
      var result = true

      services.forEach {
        if let res = $0.application?(application, willFinishLaunchingWithOptions: launchOptions), !res {
          result = false
        }
      }
      return result
    }

}

