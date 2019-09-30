//
//  UsersListPresenter.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 30/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import SharedComponents

// Router protocol for the UsersListPresenter class.
protocol UsersListPresenterRouter: class {
  // Since the flow is made of one single screen, the implementation of this protocol by the router is going to be empty.
  // Added in order to demonstrate the dependency between this clase and the MainFlowCoordinator in terms of navigation/routing.
  func didTapNext()
}

final class UsersListPresenter {
  
  weak var output: UsersListPresenterOutput?
  weak var router: UsersListPresenterRouter?
  var interactor: UsersListInteractorInput?
  private var data = [User]()
  
}
  
extension UsersListPresenter: UsersListPresenterInput {
  
  func presentData() {
    output?.displayUsersList(with: UsersListViewModel(models: data, isLoading: true))
    interactor?.fetchUsers()
  }
  
  func didTapPrimaryButtonForElement(at index: Int) {
    guard let user = data[safe: index] else {
      return
    }
    user.isFollowed ? interactor?.unfollowUser(user.identifier) : interactor?.followUser(user.identifier)
  }
  
  func didTapSecondaryButtonForElement(at index: Int) {
    guard let user = data[safe: index] else {
      return
    }
    interactor?.blockUser(user.identifier)
  }
}

extension UsersListPresenter: UsersListInteractorOutput {
  
  func userDidUpdate(result: OperationResult<User>) {
    switch result {
    
    case .success(let user):
      guard let userIndex = data.firstIndex(where: { $0.identifier == user.identifier }) else {
        return
      }
      output?.updateUser(at: userIndex, viewModel: UserCellViewModel(with: user))
      data[userIndex] = user
    
    case .failure(let error):
      let viewModel = UsersListViewModel(error: error)
      output?.displayUsersList(with: viewModel)
    }
  }
  
  
  func usersFetched(result: OperationResult<[User]>) {
    let viewModel: UsersListViewModel
    switch result {
    case .success(let users):
      data = users
      viewModel = UsersListViewModel(models: data)
      output?.displayUsersList(with: viewModel)
    case .failure(let error):
      viewModel = UsersListViewModel(error: error)
    }
    output?.displayUsersList(with: viewModel)
  }
}
