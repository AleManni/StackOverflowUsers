//
//  UserNetworkModelTest.swift
//  StackOverflowUsersTests
//
//  Created by Alessandro Manni on 30/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import XCTest
import SharedComponents
@testable import StackOverflowUsers


class UserNetworkModelTest: XCTestCase {
  
  func testNetworkUser() {
    
    let bundle = Bundle(for: UserNetworkModelTest.self)
    
    do {
      let json = try TestUtilities.loadJSONFile("users_list", inBundle: bundle)
      let userList = try JSONDecoder().decode(UsersListNetworkModel.self, from: json)
      let users = userList.users
      XCTAssertNotNil(userList)
      XCTAssertEqual(users.count, 20)
      XCTAssertEqual(users.first?.identifier, 11683)
      XCTAssertEqual(users.first?.name, "Jon Skeet")
      XCTAssertEqual(users.first?.reputation, 1134386)
      XCTAssertEqual(users.first?.imageURL, "https://www.gravatar.com/avatar/6d8ebb117e8d83d74ea95fbdd0f87e13?s=128&d=identicon&r=PG")
    } catch let error {
      XCTFail("\(error.localizedDescription)")
    }
  }
}
