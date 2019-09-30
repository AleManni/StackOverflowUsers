//
//  AppCoordinatorService.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 29/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import SharedComponents

final class AppCoordinator {
    
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
