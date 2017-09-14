//
//  MapPresenter.swift
//  RealmMapViewMVP
//
//  Created by Amadeu Andrade on 12/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation
import RealmSwift
import CoreLocation
import RealmSwiftSFRestaurantData

protocol MapPresenterRepresentable {
  var realmConfiguration: Realm.Configuration { get }
  
  var didUpdateUserLocation: ((Result<CLLocation>)->Void)? { get set }
  var didUpdateAuthorization: ((Result<Void>)->Void)? { get set }

  func requestUserLocation()
  
  func showDetails(for restaurant: ABFRestaurantObject)
}

class MapPresenter: MapPresenterRepresentable {

  // MARK: - DEPENDENCIES
  
  private var locationManager: LocationManagerProtocol
  private let navigator: NavigatorRepresentable
  
  // MARK: - OUTPUT PROPERTIES
  
  let realmConfiguration = RealmConfig.main.configuration
  var didUpdateUserLocation: ((Result<CLLocation>)->Void)?
  var didUpdateAuthorization: ((Result<Void>)->Void)?

  // MARK: - INITIALIZER
  
  init(locationManager: LocationManagerProtocol, navigator: NavigatorRepresentable) {
    self.navigator = navigator
    self.locationManager = locationManager
    
    self.locationManager.didUpdateUserLocation = { [weak self] result in
      switch result {
      case .success(let userLocation):
        self?.didUpdateUserLocation?(.success(userLocation))
      case .failure(let error):
        self?.didUpdateUserLocation?(.failure(error))
      }
    }
    self.locationManager.didUpdateAuthorization = { [weak self] result in
      switch result {
      case .success:
        self?.didUpdateAuthorization?(.success())
      case .failure(let error):
        self?.didUpdateAuthorization?(.failure(error))
      }
    }
  }
  
  // MARK: - NAVIGATION
  
  func showDetails(for restaurant: ABFRestaurantObject) {
    let detailsPresenter = RestaurantDetailsPresenter()
    navigator.transition(to: .details(detailsPresenter), type: .push)
  }
  
  // MARK: - METHODS
  
  func requestUserLocation() {
    locationManager.requestUserLocation()
  }
  
}
