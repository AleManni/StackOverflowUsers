//
//  UsersListViewModel.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 30/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//


import SharedComponents

struct UsersListViewModel {
  
  struct UsersListTableViewModel {
    let displayLoadingIndicator: Bool
    let requiresPlaceholder: Bool
    let cellViewModels: [UserCellViewModel]
    let placeholderViewModel: PlaceholderViewModel
  }
  
  let title: String
  let errorWarning: String?
  let tableModel: UsersListTableViewModel
}

extension UsersListViewModel {
  
  init(models: [User] = [], error: Error? = nil, isLoading: Bool = false) {
    self.title = NSLocalizedString("Top Users", comment: "")
    self.errorWarning = error?.localizedDescription
    self.tableModel = UsersListTableViewModel(models: models, isLoading: isLoading)
  }
}

extension UsersListViewModel.UsersListTableViewModel {
  
  init(models: [User], isLoading: Bool) {
    displayLoadingIndicator = isLoading
    requiresPlaceholder = models.count == 0
    cellViewModels = models.map { UserCellViewModel(with: $0)}
    placeholderViewModel = PlaceholderViewModel(primaryText: NSLocalizedString("No users found", comment: "Placeholder primary text for no users"),
                                                secondaryText: NSLocalizedString("Pull to retry", comment: "Placeholder secondary text for no users"))
  }
}
