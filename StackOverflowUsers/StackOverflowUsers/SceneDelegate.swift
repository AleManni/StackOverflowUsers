//
//  SceneDelegate.swift
//  test2
//
//  Created by Alessandro Manni on 30/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  
  lazy var appCoordinator = AppCoordinator()
  
  func scene(_ scene: UIScene,
             willConnectTo session: UISceneSession,
             options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
    window?.rootViewController = appCoordinator.mainFlowCoordinator?.navigationController
    window?.makeKeyAndVisible()
    appCoordinator.mainFlowCoordinator?.start()
  }
}
