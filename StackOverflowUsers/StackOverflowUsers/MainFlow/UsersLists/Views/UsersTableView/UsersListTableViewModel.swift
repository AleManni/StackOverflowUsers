//
//  UsersListTableViewModel.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 30/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import SharedComponents

struct UsersListTableViewModel {
  let displayLoadingIndicator: Bool
  let requiresPlaceholder: Bool
  let cellViewModels: [UserCellViewModel]
  let placeholderViewModel: PlaceholderViewModel
}
