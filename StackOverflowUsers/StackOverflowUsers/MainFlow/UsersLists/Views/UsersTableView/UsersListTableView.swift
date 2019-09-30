//
//  UsersListTableView.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 30/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import SharedComponents


protocol UserListTableViewActionDelegate: class {
  func didTapPrimaryButtonAtIndex(_ index: Int)
  func didTapSecondaryButtonAtIndex(_ index: Int)
}

final class UsersListTableView: BaseTableView {
  
  weak var actionDelegate: UserListTableViewActionDelegate?
  
  var cellViewModels: [UserCellViewModel] = []
  
  override init(style: UITableView.Style) {
    super.init(style: style)
    register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: UserCell.identifier)
    tableFooterView = UIView()
    self.dataSource = self
    self.delegate = self
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func populate(with viewModel: UsersListTableViewModel) {
    endRefreshing()
    self.cellViewModels = viewModel.cellViewModels
    self.isLoading = viewModel.displayLoadingIndicator
    self.populatePlaceholder(with: viewModel.placeholderViewModel)
    self.requiresPlaceholder = viewModel.requiresPlaceholder
    reloadData()
  }
  
  func updateCell(at indexPath: IndexPath, with viewModel: UserCellViewModel) {
    cellViewModels[indexPath.row] = viewModel
    if let visibleIndexPaths = indexPathsForVisibleRows?.firstIndex(of: indexPath as IndexPath) {
        if visibleIndexPaths != NSNotFound {
            reloadRows(at: [indexPath], with: .fade)
        }
    }
  }
}

extension UsersListTableView: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return cellViewModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = dequeueReusableCell(withIdentifier: UserCell.identifier) as? UserCell,
      let viewModel = cellViewModels[safe: indexPath.row] else {
        return UITableViewCell()
    }
    cell.delegate = self
    cell.populate(with: viewModel)
    return cell
  }
}

extension UsersListTableView: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    deselectRow(at: indexPath, animated: true)
    if let cell = cellForRow(at: indexPath) as? UserCell {
      cell.didTouch()
      tableView.beginUpdates()
      tableView.endUpdates()
    }
  }
}

extension UsersListTableView: UserCellDelegate {
  
  func cellDidTapPrimaryButton(_ cell: UserCell) {
    if let row = indexPath(for: cell)?.row {
      actionDelegate?.didTapPrimaryButtonAtIndex(row)
    }
  }
  
  func cellDidTapSecondaryButton(_ cell: UserCell) {
    if let row = indexPath(for: cell)?.row {
      actionDelegate?.didTapSecondaryButtonAtIndex(row)
    }
  }
  
}
