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
  func viewDidLoad()
  func didTapPrimaryButtonForElement(at index: Int)
  func didTapSecondaryButtonForElement(at index: Int)
  func didTapCell(at index: Int) 
}

protocol UsersListPresenterOutput: class {
  func displayUsersList(with viewModel: UsersListViewModel)
  func displayUpdate(at index: Int, with viewModel: UserCellViewModel)
}

// Since the flow is made of one single screen, the implementation of this protocol by the router is going to be empty.
// Added here in order to demonstrate the dependency between the Presenter and the MainFlowCoordinator in terms of navigation/routing.
protocol UsersListPresenterRouter: class {
  func didTapNext()
}


