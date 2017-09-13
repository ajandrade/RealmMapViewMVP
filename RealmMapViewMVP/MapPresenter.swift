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

protocol MapPresenterRepresentable {
  var realmConfiguration: Realm.Configuration { get }
  
  var didUpdateUserLocation: ((Result<CLLocation>)->Void)? { get set }
  var didUpdateAuthorization: ((Result<Void>)->Void)? { get set }

  func requestUserLocation()
}

class MapPresenter: MapPresenterRepresentable {

  // MARK: - DEPENDENCIES
  
  private var locationManager: LocationManagerProtocol
  
  // MARK: - OUTPUT PROPERTIES
  
  let realmConfiguration = RealmConfig.main.configuration
  var didUpdateUserLocation: ((Result<CLLocation>)->Void)?
  var didUpdateAuthorization: ((Result<Void>)->Void)?

  // MARK: - INITIALIZER
  
  init(locationManager: LocationManagerProtocol) {
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
  
  // MARK: - METHODS
  
  func requestUserLocation() {
    locationManager.requestUserLocation()
  }
  
}
