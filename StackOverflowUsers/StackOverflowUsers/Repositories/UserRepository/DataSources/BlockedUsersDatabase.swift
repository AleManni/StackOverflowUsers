//
//  BlockedUsersDatabase.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 29/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

protocol BlockedUsersDatabaseProtocol {
  
  func blockUser(_ userId: Int)
  func isUserBlocked(_ userId: Int) -> Bool
  
}


final class BlockedUsersDatabase: BlockedUsersDatabaseProtocol {
  
  lazy var users = Set<Int>()
  
  func blockUser(_ userId: Int) {
    users.insert(userId)
  }
  
  func isUserBlocked(_ userId: Int) -> Bool {
    return users.contains(userId)
  }
}
