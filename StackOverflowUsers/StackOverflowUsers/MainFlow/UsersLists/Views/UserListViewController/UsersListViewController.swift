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
  
  private lazy var tableView: BaseTableView = {
    let table = BaseTableView(style: .plain)
    table.refreshDelegate = self
    table.tableFooterView = UIView()
    table.dataSource = self
    table.delegate = self
    return table
  }()
  
  private lazy var errorBanner = ErrorBannerView(frame: .zero)
  private let errorBannerHeight: CGFloat = 40
  private var errorBannerTopConstraint: NSLayoutConstraint?
  private var errorBannerOffset: CGFloat?
  private var tableSourceItems: [UserCellViewModel] = []
  
  // MARK: - Lifecycle
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: UserCell.identifier)
    presenter?.viewDidLoad()
  }
  
  // MARK: - private methods
  
  private func setupView() {
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
    
    errorBannerTopConstraint = errorBanner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
    errorBannerTopConstraint?.constant = errorBannerOffset ?? -errorBannerHeight
    errorBannerTopConstraint?.isActive = true
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

// MARK: - UsersListPresenterOutput
extension UsersListViewController: UsersListPresenterOutput {
  
  func displayUsersList(with viewModel: UsersListViewModel) {
    self.title = viewModel.title
    displayWarning(viewModel.errorWarning)
    tableSourceItems = viewModel.tableModel.cellViewModels
    tableView.endRefreshing()
    tableView.isLoading = viewModel.tableModel.displayLoadingIndicator
    tableView.populatePlaceholder(with: viewModel.tableModel.placeholderViewModel)
    tableView.requiresPlaceholder = viewModel.tableModel.requiresPlaceholder
    tableView.reloadData()
  }
  
  func displayUpdate(at index: Int, with viewModel: UserCellViewModel) {
      tableSourceItems[index] = viewModel
    let indexPath = IndexPath(row: index, section: 0)
    if let visibleIndexPaths = tableView.indexPathsForVisibleRows?.firstIndex(of: indexPath as IndexPath) {
          if visibleIndexPaths != NSNotFound {
            tableView.reloadRows(at: [indexPath], with: .fade)
          }
      }
    }
}

// MARK: - BaseTableViewRefreshDelegate
extension UsersListViewController: BaseTableViewRefreshDelegate {
  func didPullToRefresh() {
    presenter?.viewDidLoad()
  }
}

// MARK: - UITableViewDataSource
extension UsersListViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableSourceItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier) as? UserCell,
      let viewModel = tableSourceItems[safe: indexPath.row] else {
        return UITableViewCell()
    }
    cell.delegate = self
    cell.populate(with: viewModel)
    return cell
  }
}

// MARK: - UITableViewDelegate
extension UsersListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    presenter?.didTapCell(at: indexPath.row)
  }
}

// MARK: - UserCellDelegate
extension UsersListViewController: UserCellDelegate {
  
  func cellDidTapPrimaryButton(_ cell: UserCell) {
    if let index = tableView.indexPath(for: cell)?.row {
      presenter?.didTapPrimaryButtonForElement(at: index)
    }
  }
  
  func cellDidTapSecondaryButton(_ cell: UserCell) {
    if let index = tableView.indexPath(for: cell)?.row {
      presenter?.didTapSecondaryButtonForElement(at: index)
    }
  }
}
