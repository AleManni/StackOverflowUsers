//
//  UsersListViewController.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 30/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import SharedComponents

final class UsersListViewController: UIViewController {
  
  var presenter: UsersListPresenterInput?
  
  lazy var tableView: UsersListTableView = {
    let table = UsersListTableView(style: .plain)
    table.refreshDelegate = self
    table.actionDelegate = self
    return table
  }()
  
  lazy var errorBanner = ErrorBannerView(frame: .zero)
  
  var errorBannerTopConstraint: NSLayoutConstraint?
  
  private let errorBannerHeight: CGFloat = 40
  
  private var errorBannerOffset: CGFloat?
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    view.addSubview(tableView)
    view.addSubview(errorBanner)
    
    tableView.translatesAutoresizingMaskIntoConstraints = false
    errorBanner.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      
      errorBanner.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      errorBanner.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      errorBanner.heightAnchor.constraint(equalToConstant: errorBannerHeight),
      
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: errorBanner.bottomAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    errorBannerTopConstraint = errorBanner.topAnchor.constraint(equalTo: view.topAnchor)
    errorBannerTopConstraint?.constant = errorBannerOffset ?? -errorBannerHeight
    errorBannerTopConstraint?.isActive = true
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    presenter?.presentData()
  }
  
  private func displayWarning(_ warning: String?) {
    errorBannerOffset = warning != nil ? 0 : -errorBannerHeight
    errorBanner.setWarning(text: warning)
    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
      self.errorBannerTopConstraint?.constant = self.errorBannerOffset ?? 0
      self.view.layoutIfNeeded()
    }, completion: nil)
  }

}


extension UsersListViewController: BaseTableViewRefreshDelegate {
  func didPullToRefresh() {
    presenter?.presentData()
  }
}

extension UsersListViewController: UserListTableViewActionDelegate {
  
  func didTapPrimaryButtonAtIndex(_ index: Int) {
    presenter?.didTapPrimaryButtonForElement(at: index)
  }
  
  func didTapSecondaryButtonAtIndex(_ index: Int) {
    presenter?.didTapSecondaryButtonForElement(at: index)
  }
  
}


extension UsersListViewController: UsersListPresenterOutput {
  
  func displayUsersList(with viewModel: UsersListViewModel) {
    self.title = viewModel.title
    if let warning = viewModel.errorWarning {
    displayWarning(warning)
    }
    tableView.populate(with: viewModel.tableModel)
  }
  
  func updateUser(at index: Int, viewModel: UserCellViewModel) {
    // TO BE IMPLEMENTED
  }

}
