//
//  UsersListProtocols.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 30/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//


import SharedComponents

protocol UsersListInteractorInput: class {
  func fetchUsers()
  func followUser(_ userId: Int)
  func unfollowUser(_ userId: Int)
  func blockUser(_ userId: Int)
}

protocol UsersListInteractorOutput: class {
  func usersFetched(result: OperationResult<[User]>)
  func userDidUpdate(result: OperationResult<User>)
}

protocol UsersListPresenterInput: class {
  func presentData()
  func didTapPrimaryButtonForElement(at index: Int)
  func didTapSecondaryButtonForElement(at index: Int)
}

protocol UsersListPresenterOutput: class {
  func displayUsersList(with viewModel: UsersListViewModel)
  func updateUser(at index: Int, viewModel: UserCellViewModel)
}

//protocol UsersListDisplayableInput: class {
//  func viewDidLoad()
//}


