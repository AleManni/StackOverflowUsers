//
//  UserReporitoryProtocol.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 29/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import SharedComponents

protocol UsersRepositoryProtocol {
  var api: UsersAPIProtocol { get }
  var followedUsersDatabase: FollowedUsersDatabaseProtocol { get }
  var blockedUsersDatabase: BlockedUsersDatabaseProtocol { get }
  
  func getUsers(completion: @escaping (OperationResult<[User]>) -> Void)
  func followUser(_ userId: Int) -> OperationResult<User> 
  func unfollowUser(_ userId: Int) -> OperationResult<User>
  func blockUser(_ userId: Int) -> OperationResult<User>
  
}
