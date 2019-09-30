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
   configureNavigationBarAppearance()
    return true
  }
}

// MARK: Navigation Bar

extension AppearanceService {
  
  private func configureNavigationBarAppearance() {
    let navBarAppearance = UINavigationBarAppearance()
    navBarAppearance.configureWithOpaqueBackground()
    navBarAppearance.backgroundColor = Colours.white.rawValue
    let titleColor = Colours.navyBlue.rawValue
    
    if #available(iOS 11.0, *) {
      navBarAppearance.titleTextAttributes = [
        NSAttributedString.Key.foregroundColor: titleColor
      ]
      navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
      UINavigationBar.appearance().prefersLargeTitles = true
      UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self]).standardAppearance = navBarAppearance
      UINavigationBar.appearance(whenContainedInInstancesOf: [UINavigationController.self]).scrollEdgeAppearance = navBarAppearance
    } else {
      navBarAppearance.titleTextAttributes = [
        NSAttributedString.Key.foregroundColor: titleColor,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0, weight: .light)
      ]
    }
  }
}

