//
//  NavigationScene.swift
//  RealmMapViewMVP
//
//  Created by Amadeu Andrade on 12/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

enum NavigationScene {
  case map(MapPresenterRepresentable)
}

extension NavigationScene {
  
  func viewController() -> UIViewController {
    switch self {
    case .map(let presenter):
      let mapViewController = MapViewController()
      mapViewController.presenter = presenter
      return mapViewController
    }
  }
  
}
