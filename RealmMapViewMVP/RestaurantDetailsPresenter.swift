//
//  RestaurantDetailsPresenter.swift
//  RealmMapViewMVP
//
//  Created by Amadeu Andrade on 14/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation
import CoreLocation
import RealmSwiftSFRestaurantData

protocol RestaurantDetailsPresenterRepresentable {
  
}

struct RestaurantDetailsPresenter: RestaurantDetailsPresenterRepresentable {

  // MARK: - DEPENDENCIES
  
  private let navigator: NavigatorRepresentable
  
  // MARK: - PRIVATE PROPERTIES
  
  private let restaurantName: String
  private let restaurantAddress: String
  private let restaurantCoordinates: CLLocationCoordinate2D
  private let restaurantPhone: String?
  private let restaurantRating: String
  
  // MARK: - INITIALIZER
  
  init(navigator: NavigatorRepresentable, restaurant: ABFRestaurantObject) {
    self.navigator = navigator
    restaurantName = restaurant.name?.capitalized ?? "Unknown name"
    restaurantAddress = restaurant.address?.capitalized ?? "Unknown address"
    restaurantPhone = restaurant.phoneNumber
    let coordinates = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
    restaurantCoordinates = coordinates
    let ratingCount = restaurant.inspections.count
    let rating = restaurant.inspections.reduce(0) { $0 + $1.score } / ratingCount
    restaurantRating = "\(rating)"
  }
  
}
