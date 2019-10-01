//
//  AppRepositories.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 29/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import SharedComponents

protocol AppRepositories {
  var usersRepository: UsersRepositoryProtocol { get }
}

final class ProductionRepositories: AppRepositories {
  
  var usersRepository: UsersRepositoryProtocol =
    UsersRepository(api: UsersAPI(NetworkService.safeSession), followedUsersDatabase: FollowedUsersDatabase(), blockedUsersDatabase: BlockedUsersDatabase())
}

