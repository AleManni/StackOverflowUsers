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
    output?.userDidUpdate(result: repository.followUser(userId))
  }
  
  func unfollowUser(_ userId: Int) {
    output?.userDidUpdate(result: repository.unfollowUser(userId))
  }
  
  func blockUser(_ userId: Int) {
    output?.userDidUpdate(result: repository.blockUser(userId))
  }
  
}

