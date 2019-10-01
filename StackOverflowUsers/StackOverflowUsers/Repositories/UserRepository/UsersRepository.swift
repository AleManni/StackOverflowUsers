//
//  UsersRepository.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 29/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import SharedComponents

final class UsersRepository: UsersRepositoryProtocol {
  
  struct UserNotFoundError: LocalizedError {
    var errorDescription: String? = NSLocalizedString("Users Repository: user not found", comment: "User not found error")
  }
  
  let api: UsersAPIProtocol
  let followedUsersDatabase: FollowedUsersDatabaseProtocol
  let blockedUsersDatabase: BlockedUsersDatabaseProtocol
  
  private lazy var apiUsers = [UserNetworkModel]()
  
  init(api: UsersAPIProtocol, followedUsersDatabase: FollowedUsersDatabase, blockedUsersDatabase: BlockedUsersDatabaseProtocol) {
    self.api = api
    self.followedUsersDatabase = followedUsersDatabase
    self.blockedUsersDatabase = blockedUsersDatabase
  }
  
  func getUsers(completion: @escaping (OperationResult<[User]>) -> Void) {
    api.getUsers { [weak self] result in
      guard let self = self else {
        return
      }
      switch result {
      case let .success(apiUsersList):
        self.apiUsers = apiUsersList.users
        let userModels = self.apiUsers.map {
          return User(apiModel: $0,
                      isFollowed: self.followedUsersDatabase.isUserFollowed($0.identifier),
                      isBlocked: self.blockedUsersDatabase.isUserBlocked($0.identifier))
        }
        completion(.success(userModels))
      case let .failure(error):
        completion(.failure(APIErrors.networkError(error)))
      }
    }
  }
  
  @discardableResult func followUser(_ userId: Int) -> OperationResult<User> {
    return editUser(userId, action: followedUsersDatabase.followUser(_:))
  }
  
  @discardableResult func unfollowUser(_ userId: Int) -> OperationResult<User> {
    return editUser(userId, action: followedUsersDatabase.unfollowUser(_:))
  }
  
  @discardableResult func blockUser(_ userId: Int) -> OperationResult<User> {
    return editUser(userId, action: blockedUsersDatabase.blockUser(_:))
  }
  
  private func editUser(_ userId: Int, action: (Int) -> Void) -> OperationResult<User> {
    guard let user = apiUsers.first(where: { $0.identifier == userId}) else {
      return .failure(UserNotFoundError())
    }
    action(userId)
    return .success(User(apiModel: user,
                         isFollowed: self.followedUsersDatabase.isUserFollowed(user.identifier),
                         isBlocked: self.blockedUsersDatabase.isUserBlocked(user.identifier)))
    
  }
}

extension User {
  
  init(apiModel: UserNetworkModel, isFollowed: Bool, isBlocked: Bool) {
    self.identifier = apiModel.identifier
    self.imageURL = apiModel.imageURL
    self.isBlocked = isBlocked
    self.isFollowed = isFollowed
    self.name = apiModel.name
    self.reputation = apiModel.reputation
  }
}
