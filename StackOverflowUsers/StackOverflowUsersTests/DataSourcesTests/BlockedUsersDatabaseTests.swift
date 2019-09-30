//
//  BlockedUsersDatabaseTests.swift
//  StackOverflowUsersTests
//
//  Created by Alessandro Manni on 29/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import XCTest
@testable import StackOverflowUsers

class BlockedUsersDatabaseTests: XCTestCase {
  
  func testBlockUser() {
    let testUserId = 12345
    //GIVEN
    let database = BlockedUsersDatabase()
    //WHEN
    database.blockUser(testUserId)
    //THEN
    XCTAssertTrue(database.isUserBlocked(testUserId))
  }
}

