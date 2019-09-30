//
//  FollowedUsersDatabase.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 29/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

protocol FollowedUsersDatabaseProtocol {
  
  func followUser(_ userId: Int)
  func unfollowUser(_ userId: Int)
  func isUserFollowed(_ userId: Int) -> Bool
}

final class FollowedUsersDatabase: FollowedUsersDatabaseProtocol {
  
  lazy var users = Set<Int>()
  
  func followUser(_ userId: Int) {
    users.insert(userId)
  }
  
  func unfollowUser(_ userId: Int) {
    users.remove(userId)
  }
  
  func isUserFollowed(_ userId: Int) -> Bool {
    return users.contains(userId)
  }
}
