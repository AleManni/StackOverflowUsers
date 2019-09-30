//
//  AppearanceService.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 29/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import SharedComponents

/**
 `AppearanceService` is an app service that manage all the app general appearance.
 */
final class AppearanceService: AppService, ApplicationService {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    setupNavigationBar()
    application.statusBarStyle = .lightContent
    return true
  }
}

// MARK: Navigation Bar

extension AppearanceService {
  
    private func setupNavigationBar() {
        let titleColor = Colours.white.rawValue

    if #available(iOS 11.0, *) {
      UINavigationBar.appearance().titleTextAttributes = [
        NSAttributedString.Key.foregroundColor: titleColor
      ]
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
    } else {
      UINavigationBar.appearance().titleTextAttributes = [
        NSAttributedString.Key.foregroundColor: titleColor,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0, weight: .light)
      ]
    }
    UINavigationBar.appearance().tintColor = .white
    UINavigationBar.appearance().barTintColor = Colours.navyBlue.rawValue
    UINavigationBar.appearance().isTranslucent = false
    if #available(iOS 11.0, *) {
      UINavigationBar.appearance().prefersLargeTitles = true
    }
  }
}

