//
//  FollowedUsersDatabaseTests.swift
//  StackOverflowUsersTests
//
//  Created by Alessandro Manni on 29/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import XCTest
@testable import StackOverflowUsers

class FollowedUsersDatabaseTests: XCTestCase {
  
  func testFollowUser() {
    let testUserId = 12345
    //GIVEN
    let database = FollowedUsersDatabase()
    //WHEN
    database.followUser(testUserId)
    //THEN
    XCTAssertTrue(database.isUserFollowed(testUserId))
  }
  
  func testUnfollowUser() {
    let testUserId = 12345
    //GIVEN
    let database = FollowedUsersDatabase()
    database.followUser(testUserId)
    //WHEN
    database.unfollowUser(testUserId)
    //THEN
    XCTAssertFalse(database.isUserFollowed(testUserId))
  }
}
