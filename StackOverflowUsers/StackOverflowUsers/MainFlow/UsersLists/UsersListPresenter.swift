//
//  UsersListPresenter.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 30/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import SharedComponents

final class UsersListPresenter {
  
  weak var output: UsersListPresenterOutput?
  weak var router: UsersListPresenterRouter?
  var interactor: UsersListInteractorInput?
  private var data = [User]()
  private var disclosedCellIndexes: Set<Int> = []
}
  
extension UsersListPresenter: UsersListPresenterInput {
  
  func viewDidLoad() {
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
  
  func didTapCell(at index: Int) {
    guard let user = data[safe: index],
      !user.isBlocked else {
        return
    }
    updatesDisclosedCellIndexes(with: index)
    let viewModel = UserCellViewModel(with: user, isDisclosed: disclosedCellIndexes.contains(index))
    output?.displayUpdate(at: index, with: viewModel)
  }
  
  private func updatesDisclosedCellIndexes(with index: Int) {
    if disclosedCellIndexes.contains(index) {
      disclosedCellIndexes.remove(index)
    } else { disclosedCellIndexes.insert(index) }
  }
}

extension UsersListPresenter: UsersListInteractorOutput {
  
   func usersFetched(result: OperationResult<[User]>) {
     let viewModel: UsersListViewModel
     
    switch result {
     case .success(let users):
       data = users
       viewModel = UsersListViewModel(models: data)
     case .failure(let error):
       viewModel = UsersListViewModel(error: error)
     }
     output?.displayUsersList(with: viewModel)
   }
  
  func userDidUpdate(result: OperationResult<User>) {
    
    switch result {
    case .success(let user):
      guard let userIndex = data.firstIndex(where: { $0.identifier == user.identifier }) else {
        return
      }
      data[userIndex] = user
      updatesDisclosedCellIndexes(with: userIndex)
      let viewModel = UserCellViewModel(with: user, isDisclosed: disclosedCellIndexes.contains(userIndex))
      output?.displayUpdate(at: userIndex, with: viewModel)
      
    case .failure(let error):
      let viewModel = UsersListViewModel(error: error)
      output?.displayUsersList(with: viewModel)
    }
  }
}
