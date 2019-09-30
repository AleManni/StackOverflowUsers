//
//  AppCoordinatorService.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 29/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import SharedComponents

/**
 `DefaultAppCoordinatorService` is an app service that initialises and manages the flow coordinators within the app.
 */
final class AppCoordinatorService: AppService {
    
    
    private var repositories: AppRepositories {
      #if TESTING
      return ProductionRepositories() // TestsRepositories()
      #else
      return ProductionRepositories()
      #endif
    }

    lazy var mainFlowCoordinator: FlowCoordinator? = {
      return MainFlowCoordinator(viewControllersFactory: ViewControllersFactory(repositories: repositories))
    }()
}

extension AppCoordinatorService: ApplicationService {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    mainFlowCoordinator?.start()
    return true
  }
}
