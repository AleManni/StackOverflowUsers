//
//  UsersRepositoryTests.swift
//  StackOverflowUsersTests
//
//  Created by Alessandro Manni on 30/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import XCTest
import SharedComponents
@testable import StackOverflowUsers


class UsersRepositoryTests: XCTestCase {
  
  var usersRepository: UsersRepository?
  
  override func setUp() {
    super.setUp()
    usersRepository = UsersRepository(api: MockUsersAPI(), followedUsersDatabase: FollowedUsersDatabase(), blockedUsersDatabase: BlockedUsersDatabase())
  }
  
  func testFetchAllSuccess() {
    // WHEN
    usersRepository?.getUsers(completion: { result in
      switch result {
      // THEN
      case .success(let users):
        XCTAssertNotNil(users)
        XCTAssertEqual(users.count, 20)
      case .failure(let error):
        XCTFail("unexpected error from call: \(error)")
      }
    })
  }
  
  func testFetchAllFailure() {
    // GIVEN
    let mockAPI = MockUsersAPI()
    mockAPI.success = false
    usersRepository = UsersRepository(api: mockAPI, followedUsersDatabase: FollowedUsersDatabase(), blockedUsersDatabase: BlockedUsersDatabase())
    // WHEN
    usersRepository?.getUsers(completion: { result in
      switch result {
      // THEN
      case .success(_):
        XCTFail("Repository get user succedded but expected to fail instead")
      case .failure(let error):
        XCTAssertTrue(error is APIErrors)
      }
    })
  }
  
  func testEditActionFail() {
    let nonExistingUserId = 123456
    usersRepository!.getUsers(completion: { _ in })
    let result = usersRepository!.followUser(nonExistingUserId)
    switch result {
    case .success(_):
      XCTFail("Repository follow user succedded but expected to fail instead")
    case .failure(let error):
      XCTAssertTrue(error is UsersRepository.UserNotFoundError)
    }
  }
  
  func testFollowUserSuccess() {
    let firstUserId = 11683
    usersRepository!.getUsers(completion: { _ in })
    let result = usersRepository!.followUser(firstUserId)
    switch result {
    case .success(let user):
      XCTAssertEqual(user.identifier, 11683)
      XCTAssertTrue(user.isFollowed)
    case .failure(let error):
      XCTFail("Follow user expected to success but failed instead with error: \(error)")
    }
  }
  
  func testUnfollowUserSuccess() {
    let firstUserId = 11683
    usersRepository!.getUsers(completion: { _ in })
    usersRepository!.followUser(firstUserId)
    let result = usersRepository!.unfollowUser(firstUserId)
    switch result {
    case .success(let user):
      XCTAssertEqual(user.identifier, 11683)
      XCTAssertFalse(user.isFollowed)
    case .failure(let error):
      XCTFail("Follow user expected to success but failed instead with error: \(error)")
    }
  }
  
  func testBlockUserSuccess() {
    let firstUserId = 11683
    usersRepository!.getUsers(completion: { _ in })
    let result = usersRepository!.blockUser(firstUserId)
    switch result {
    case .success(let user):
      XCTAssertEqual(user.identifier, 11683)
      XCTAssertTrue(user.isBlocked)
    case .failure(let error):
      XCTFail("Follow user expected to success but failed instead with error: \(error)")
    }
  }
  
  // Refetching users from API will persist isFollowed or isBlocked values for all users
  func testReloadUsersPersistingLocalSettings() {
    let firstUserId = 11683
    usersRepository!.getUsers(completion: { _ in })
    usersRepository!.blockUser(firstUserId)
    usersRepository!.getUsers(completion: { result in
      switch result {
      // THEN
      case .success(let users):
        XCTAssertTrue(users.first(where: { $0.identifier == firstUserId })?.isBlocked ?? false)
      case .failure(let error):
        XCTFail("unexpected error from call: \(error)")
      }
    })
  }
}
