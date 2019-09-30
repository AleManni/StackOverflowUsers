//
//  UsersListInteractor.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 30/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import SharedComponents

final class UsersListInteractor {

  private let repository: UsersRepositoryProtocol
  private var users = [User]()
  
  weak var output: UsersListInteractorOutput?
  
  init(repository: UsersRepositoryProtocol) {
    self.repository = repository
  }
  
}

extension UsersListInteractor: UsersListInteractorInput {
  
  func fetchUsers() {
    repository.getUsers(completion: { [weak self] result in
      self?.output?.usersFetched(result: result)})
  }
  
  func followUser(_ userId: Int) {
    let updateResult = repository.followUser(userId)
    propagateUpdate(with: updateResult)
  }
  
  func unfollowUser(_ userId: Int) {
    let updateResult = repository.unfollowUser(userId)
    propagateUpdate(with: updateResult)
  }
  
  func blockUser(_ userId: Int) {
    let updateResult = repository.blockUser(userId)
    propagateUpdate(with: updateResult)
  }
  
  private func propagateUpdate(with result: OperationResult<User>) {
    output?.userDidUpdate(result: result)
    switch result {
    case .success(let user):
      if let index = users.firstIndex(where: { $0.identifier == user.identifier }) {
        users[index] = user
      }
    default:
      break
    }
  }  
}
