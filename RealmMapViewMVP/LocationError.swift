//
//  LocationError.swift
//  RealmMapViewMVP
//
//  Created by Amadeu Andrade on 13/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation

enum LocationError: Error {
  // Auth
  case authError
  case denied
  // Requests
  case locationError
}

extension LocationError: LocalizedError {

  public var description: String {
    switch self {
    case .authError:
      return "The location service needs your authorization."
    case .denied:
      return "You did not authorize the location services."
    case .locationError:
      return "Couldn't find your location! Please check you GPS status."
    }
  }
}
