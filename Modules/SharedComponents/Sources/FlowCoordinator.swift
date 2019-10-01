//
//  FlowCoordinator.swift
//  Shared Elements
//
//  Created by Alessandro Manni on 16/08/2018.
//  Copyright © 2018 Alessandro Manni. All rights reserved.
//

import Foundation
import UIKit

public protocol FlowCoordinator {
  var navigationController: UINavigationController { get }
  func start()
}

public extension FlowCoordinator {
  
  var currentViewController: UIViewController {
    return navigationController.visibleViewController ?? UIViewController()
  }
  
  func showController(_ controller: UIViewController) {
    navigationController.pushViewController(controller, animated: true)
  }
  
  func backToRoot() {
    navigationController.popToRootViewController(animated: true)
  }
}
