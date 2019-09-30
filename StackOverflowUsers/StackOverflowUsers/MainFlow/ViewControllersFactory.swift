//
//  ViewControllersFactory.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 29/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

/**
 The ViewControllersFactory operates as a factory for its client (the MainFlowCoordinator)
 The initialization method allows to inject a class conforming to BudRepositories that provides concrete repositories implementations to the ModulesFactory.
 Such class will provide the repositories used by the ModulesFactory implementation in order to build each Module.
 In this instance, TestRepositories is used to feed mock data during UI tests
 */

final class ViewControllersFactory {

  let repositories: AppRepositories

  init(repositories: AppRepositories) {
    self.repositories = repositories
  }
}

extension ViewControllersFactory {
  
   //  func buildUsersListView(router: FlowCoordinator) -> UsersListViewController {
   //    let view = TransactionsViewController()
   //    let interactor = TransactionsInteractor(repository: repositories.transactionsRepository)
   //    let presenter = TransactionsPresenter()
   //    view.presenter = presenter
   //    presenter.interactor = interactor
   //    interactor.output = presenter
   //    presenter.view = view
   //    presenter.router = router
   //    return view
   //  }

}

