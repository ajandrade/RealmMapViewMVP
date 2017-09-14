//
//  AppDelegate.swift
//  RealmMapViewMVP
//
//  Created by Amadeu Andrade on 12/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow()
    let navigator = Navigator(window: window!)
    let locationManager = LocationManager()
    let presenter = MapPresenter(locationManager: locationManager, navigator: navigator)
    let rootViewController = NavigationScene.map(presenter)
    navigator.transition(to: rootViewController, type: .root)

    return true
  }

}

