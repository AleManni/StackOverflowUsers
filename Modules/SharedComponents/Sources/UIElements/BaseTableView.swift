//
//  BaseTableView.swift
//  SharedComponents
//
//  Created by Alessandro Manni on 20/08/2018.
//  Copyright © 2018 Alessandro Manni. All rights reserved.
//

import Foundation
import UIKit

public protocol BaseTableViewRefreshDelegate: class {
  func didPullToRefresh()
}
/**
 Provides a table view instantiated with a placeholder and a refresh controller
 */
open class BaseTableView: UITableView {
  
  private let placeholderView = PlaceHolderView()
  public weak var refreshDelegate: BaseTableViewRefreshDelegate?
  
  private lazy var refreshController: UIRefreshControl = {
    let control = UIRefreshControl()
    control.addTarget(self, action: #selector(refresh), for: .valueChanged)
    return control
  }()
  
  private lazy var activityIndicator = UIActivityIndicatorView(style: .gray)
  
  public var requiresPlaceholder: Bool = true {
    didSet {
      if requiresPlaceholder {
        addSubview(placeholderView)
        addSubview(refreshController)
        setPlaceholderConstraints()
        layoutIfNeeded()
      } else {
        placeholderView.removeFromSuperview()
      }
    }
  }
  
  public var isLoading: Bool = false {
    didSet {
      backgroundView = activityIndicator
      isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
  }
  
  /**
   Class initialiser
   - parameter placeholder: an instance of a PlaceHolderView class
   - parameter style: UITableViewStyle fof the table view
   */
  public init(style: UITableView.Style = .plain) {
    super.init(frame: CGRect.zero, style: style)
    addSubview(refreshController)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public func populatePlaceholder(with viewModel: PlaceholderViewModel) {
    placeholderView.populate(with: viewModel)
  }
  
  public func endRefreshing() {
    refreshController.endRefreshing()
  }
  
  //MARK: - Utilities
  
  private func setPlaceholderConstraints() {
    placeholderView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      placeholderView.topAnchor.constraint(equalTo: topAnchor),
      placeholderView.bottomAnchor.constraint(equalTo: bottomAnchor),
      placeholderView.leadingAnchor.constraint(equalTo: leadingAnchor),
      placeholderView.trailingAnchor.constraint(equalTo: trailingAnchor)])
    
    let width = placeholderView.widthAnchor.constraint(equalTo: widthAnchor)
    width.priority = .defaultHigh
    width.isActive = true
    
    let height = placeholderView.heightAnchor.constraint(equalTo: heightAnchor)
    height.priority = .defaultHigh
    height.isActive = true
  }

  @objc func refresh() {
    refreshDelegate?.didPullToRefresh()
  }
}
