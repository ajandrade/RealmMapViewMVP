//
//  MKMapView.swift
//  RealmMapViewMVP
//
//  Created by Amadeu Andrade on 13/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import MapKit

extension MKMapView {

  func center(on location: CLLocation, withRadius radius: Double) {
    let region = MKCoordinateRegionMakeWithDistance(location.coordinate, radius, radius)
    self.setRegion(region, animated: true)
  }

}
