//
//  MainFlowCoordinator.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 29/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import SharedComponents
import UIKit

/**
 This class operates as a Navigation Service for the Main Flow ( ~ router for the related VIPER modules).
 Individual extensions of this class conform to the Router protocols of the different modules.
 */
final class MainFlowCoordinator: FlowCoordinator {

  let factory: ViewControllersFactory

  lazy var navigationController: UINavigationController = {
    return UINavigationController(nibName: nil, bundle: nil)
  }()

  // MARK: Initialisation
  init(viewControllersFactory: ViewControllersFactory) {
    self.factory = viewControllersFactory
  }

  func start() {
    showUsersList()
  }
}

extension MainFlowCoordinator {
/*
   Sets the initial screen for the app
 */
  private func showUsersList() {
    let usersListViewController = factory.buildUsersListView(router: self)
    navigationController.setViewControllers([usersListViewController], animated: true)
  }
}

extension MainFlowCoordinator: UsersListPresenterRouter {
  
  func didTapNext() {
    // Empty
  }
}

