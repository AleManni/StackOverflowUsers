//
//  UserCellViewModelTests.swift
//  StackOverflowUsersTests
//
//  Created by Alessandro Manni on 01/10/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import XCTest
@testable import StackOverflowUsers

class UserCellViewModelTests: XCTestCase {
  
  func testUserCellViewModelInitialState() {
    // GiVEN
    let mockUsers = User.mocks(number: 2, areFollowed: false, areBlocked: false)
    // WHEN
    let viewModel1 = UserCellViewModel(with: mockUsers.first!)
    // THEN
    XCTAssertEqual(viewModel1.primaryLabelText, "User 1")
    XCTAssertEqual(viewModel1.secondaryLabelText, "1000")
    XCTAssertEqual(viewModel1.mainImageURL, "imageURLForUser1")
    XCTAssertEqual(viewModel1.icon, "")
    XCTAssertEqual(viewModel1.primaryButtonTitle, "Follow")
    XCTAssertEqual(viewModel1.secondayButtonTitle, "Block")
    XCTAssertFalse(viewModel1.isDisabled)
    XCTAssertFalse(viewModel1.isDisclosed)
    
    let viewModel2 = UserCellViewModel(with: mockUsers[1])
    // THEN
    XCTAssertEqual(viewModel2.primaryLabelText, "User 2")
    XCTAssertEqual(viewModel2.secondaryLabelText, "2000")
    XCTAssertEqual(viewModel2.mainImageURL, "imageURLForUser2")
    XCTAssertEqual(viewModel2.icon, "")
    XCTAssertEqual(viewModel2.primaryButtonTitle, "Follow")
    XCTAssertEqual(viewModel2.secondayButtonTitle, "Block")
    XCTAssertFalse(viewModel2.isDisabled)
    XCTAssertFalse(viewModel2.isDisclosed)
  }
  
  func testUserCellViewModelFollowed() {
    // GiVEN
    let mockUsers = User.mocks(number: 1, areFollowed: true, areBlocked: false)
    // WHEN
    let viewModel = UserCellViewModel(with: mockUsers.first!)
    // THEN
    XCTAssertEqual(viewModel.primaryLabelText, "User 1")
    XCTAssertEqual(viewModel.secondaryLabelText, "1000")
    XCTAssertEqual(viewModel.mainImageURL, "imageURLForUser1")
    XCTAssertEqual(viewModel.icon, "❤️")
    XCTAssertEqual(viewModel.primaryButtonTitle, "Unfollow")
    XCTAssertEqual(viewModel.secondayButtonTitle, "Block")
    XCTAssertFalse(viewModel.isDisabled)
    XCTAssertFalse(viewModel.isDisclosed)
  }
  
  func testUserCellViewModelBlocked() {
    // GiVEN
    let mockUsers = User.mocks(number: 1, areFollowed: false, areBlocked: true)
    // WHEN
    let viewModel = UserCellViewModel(with: mockUsers.first!)
    // THEN
    XCTAssertEqual(viewModel.primaryLabelText, "User 1")
    XCTAssertEqual(viewModel.secondaryLabelText, "1000")
    XCTAssertEqual(viewModel.mainImageURL, "imageURLForUser1")
    XCTAssertEqual(viewModel.icon, "")
    XCTAssertEqual(viewModel.primaryButtonTitle, "Follow")
    XCTAssertEqual(viewModel.secondayButtonTitle, "Block")
    XCTAssertTrue(viewModel.isDisabled)
    XCTAssertFalse(viewModel.isDisclosed)
  }
}
