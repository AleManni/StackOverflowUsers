//
//  MockUser.swift
//  StackOverflowUsersTests
//
//  Created by Alessandro Manni on 01/10/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

@testable import StackOverflowUsers

extension User {
  
  static func mocks(number: Int, areFollowed: Bool, areBlocked: Bool) -> [User] {
    return (1...number).map {
      return User(identifier: $0,
                  name: "User \($0)",
        reputation: $0*1000,
        imageURL: "imageURLForUser\($0)",
        isFollowed: areFollowed,
        isBlocked: areBlocked)
    }
  }
}
