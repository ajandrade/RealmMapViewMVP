//
//  Navigator.swift
//  RealmMapViewMVP
//
//  Created by Amadeu Andrade on 12/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

protocol NavigatorRepresentable {
  init(window: UIWindow)
  func transition(to scene: NavigationScene, type: NavigationTransitionType)
  func dismiss()
  func pop()
}

struct Navigator {
  
  // MARK: - DEPENDENCIES
  
  private let window: UIWindow
  
  // MARK: - PROPERTIES
  
  fileprivate let navigationController: UINavigationController = {
    let navController = UINavigationController()
    navController.setNavigationBarHidden(true, animated: false)
    return navController
  }()
  
  // MARK: - INITIALIZER
  
  init(window: UIWindow) {
    self.window = window
    self.window.rootViewController = navigationController
    self.window.makeKeyAndVisible()
  }
  
}

extension Navigator: NavigatorRepresentable {
  
  func transition(to scene: NavigationScene, type: NavigationTransitionType) {
    let viewController = scene.viewController()
    switch type {
    case .root:
      navigationController.viewControllers = [viewController]
    case .modal:
      navigationController.present(viewController, animated: true, completion: nil)
    case .push:
      navigationController.pushViewController(viewController, animated: true)
    }
  }
  
  func pop() {
    navigationController.popViewController(animated: true)
  }
  
  func dismiss() {
    navigationController.dismiss(animated: true, completion: nil)
  }
  
}
