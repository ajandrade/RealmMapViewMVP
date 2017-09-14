//
//  LocationManager.swift
//  RealmMapViewMVP
//
//  Created by Amadeu Andrade on 13/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol {
  var didUpdateUserLocation: ((Result<CLLocation>)->Void)? { get set }
  var didUpdateAuthorization: ((Result<Void>)->Void)? { get set }
  func requestUserLocation()
}

class LocationManager: NSObject {

  // MARK: - PRIVATE PROPERTIES
  
  fileprivate var locationManager: CLLocationManager = {
    let manager = CLLocationManager()
    manager.desiredAccuracy = kCLLocationAccuracyBest
    return manager
  }()

  // MARK: - OUTPUT PROPERTIES
  
  var didUpdateUserLocation: ((Result<CLLocation>)->Void)?
  var didUpdateAuthorization: ((Result<Void>)->Void)?
		
  // MARK: - INITIALIZER
  
  override init() {
    super.init()
    locationManager.delegate = self
    requestAuth()
  }
  
  // MARK: - METHODS
  
  fileprivate func requestAuth() {
    if CLLocationManager.authorizationStatus() == .notDetermined {
      locationManager.requestWhenInUseAuthorization()
    }
  }
  
  fileprivate func locationServicesEnabled() -> Bool {
    return CLLocationManager.locationServicesEnabled()
  }
  
}

extension LocationManager: CLLocationManagerDelegate {

  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.first {
      didUpdateUserLocation?(.success(location))
    } else {
      didUpdateUserLocation?(.failure(LocationError.locationError))
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .notDetermined:
      requestAuth()
    case .authorizedWhenInUse:
      requestUserLocation()
    case .denied:
      didUpdateAuthorization?(.failure(LocationError.denied))
    default:
      break
    }
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    didUpdateUserLocation?(.failure(LocationError.locationError))
  }
  
}

extension LocationManager: LocationManagerProtocol {
  
  func requestUserLocation() {
    if locationServicesEnabled() {
      locationManager.requestLocation()
    } else {
      didUpdateUserLocation?(.failure(LocationError.locationError))
    }
  }

}
