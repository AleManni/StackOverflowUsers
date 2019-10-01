//
//  AppCoordinator.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 29/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import SharedComponents

final class AppCoordinator {
    
    private var repositories: AppRepositories {
      #if UITEST
      // Not scoped in this demo app, but here you can inject the mock repos to be used by the ui tests target
      return ProductionRepositories()
      #else
      return ProductionRepositories()
      #endif
    }

    lazy var mainFlowCoordinator: FlowCoordinator? = {
      return MainFlowCoordinator(viewControllersFactory: ViewControllersFactory(repositories: repositories))
    }()
}
