//
//  UsersListViewModelTests.swift
//  StackOverflowUsersTests
//
//  Created by Alessandro Manni on 01/10/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import XCTest
@testable import StackOverflowUsers

class  UsersListViewModelTests: XCTestCase {
  
  func testUserListLoadingState() {
    // GiVEN
    let mockUsers = User.mocks(number: 20, areFollowed: false, areBlocked: false)
    // WHEN
    let viewModel = UsersListViewModel(models: mockUsers, error: nil, isLoading: true)
    // THEN
    XCTAssertNil(viewModel.errorWarning)
    XCTAssertEqual(viewModel.title, "Top Users")
    XCTAssertEqual(viewModel.tableModel.cellViewModels.count, 20)
    XCTAssertTrue(viewModel.tableModel.displayLoadingIndicator)
    XCTAssertNotNil(viewModel.tableModel.placeholderViewModel)
    XCTAssertFalse(viewModel.tableModel.requiresPlaceholder)
  }
  
  func testUserListPlaceholderState() {
    let viewModel = UsersListViewModel(models: [], error: nil, isLoading: false)
    // THEN
    XCTAssertNil(viewModel.errorWarning)
    XCTAssertEqual(viewModel.title, "Top Users")
    XCTAssertEqual(viewModel.tableModel.cellViewModels.count, 0)
    XCTAssertFalse(viewModel.tableModel.displayLoadingIndicator)
    XCTAssertNotNil(viewModel.tableModel.placeholderViewModel)
    XCTAssertTrue(viewModel.tableModel.requiresPlaceholder)
  }
  
  func testUserListWarningState() {
    let viewModel = UsersListViewModel(models: [], error: UsersRepository.UserNotFoundError(), isLoading: false)
    // THEN
    XCTAssertEqual(viewModel.errorWarning, "Users Repository: user not found")
    XCTAssertEqual(viewModel.title, "Top Users")
    XCTAssertEqual(viewModel.tableModel.cellViewModels.count, 0)
    XCTAssertFalse(viewModel.tableModel.displayLoadingIndicator)
    XCTAssertNotNil(viewModel.tableModel.placeholderViewModel)
    XCTAssertTrue(viewModel.tableModel.requiresPlaceholder)
  }
}


