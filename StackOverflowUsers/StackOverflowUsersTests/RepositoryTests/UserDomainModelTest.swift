//
//  UserDomainModelTest.swift
//  StackOverflowUsersTests
//
//  Created by Alessandro Manni on 30/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import XCTest
import SharedComponents
@testable import StackOverflowUsers


class UserDomainModelTest: XCTestCase {
  
  func testInitialisation() {
    // GIVEN
    let networkModel = UserNetworkModel(identifier: 1, name: "test_name", reputation: 1000, imageURL: "mockImageurl.com")
    // WHEN
    let userModel = User(apiModel: networkModel, isFollowed: true, isBlocked: false)
    // THEN
    XCTAssertEqual(userModel.identifier, networkModel.identifier)
    XCTAssertEqual(userModel.name, networkModel.name)
    XCTAssertEqual(userModel.reputation, networkModel.reputation)
    XCTAssertEqual(userModel.imageURL, networkModel.imageURL)
    XCTAssertTrue(userModel.isFollowed)
    XCTAssertFalse(userModel.isBlocked)
  }
}
