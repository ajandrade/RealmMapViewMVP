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
  var restaurantName: String { get }
  var restaurantAddress: String { get }
  var restaurantCity: String { get }
  var restaurantCoordinates: CLLocationCoordinate2D { get }
  var restaurantPhone: String { get }
  var restaurantRating: String { get }
  var phoneEnabled: Bool { get }
  
  func phonePressed()
  func dismissPressed()
}

struct RestaurantDetailsPresenter: RestaurantDetailsPresenterRepresentable {

  // MARK: - DEPENDENCIES
  
  private let navigator: NavigatorRepresentable
  
  // MARK: - OUTPUT PROPERTIES
  
  let restaurantName: String
  let restaurantAddress: String
  let restaurantCity: String
  let restaurantCoordinates: CLLocationCoordinate2D
  let restaurantPhone: String
  let restaurantRating: String
  let phoneEnabled: Bool
  
  // MARK: - INITIALIZER
  
  init(navigator: NavigatorRepresentable, restaurant: ABFRestaurantObject) {
    self.navigator = navigator
    restaurantName = restaurant.name?.capitalized ?? "Unknown name"
    restaurantAddress = restaurant.address?.capitalized ?? "Unknown address"
    restaurantCity = restaurant.city?.capitalized ?? "Unknown city"
    let hasPhone = (restaurant.phoneNumber != nil && restaurant.phoneNumber != "")
    restaurantPhone = hasPhone ? restaurant.phoneNumber! : "--- --- ----"
    phoneEnabled = hasPhone
    let coordinates = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
    restaurantCoordinates = coordinates
    let ratingCount = restaurant.inspections.count
    let rating = restaurant.inspections.reduce(0) { $0 + $1.score } / ratingCount
    restaurantRating = "\(rating)"
  }
  
  // MARK: - METHODS
  
  func dismissPressed() {
    navigator.pop()
  }
  
  func phonePressed() {
    // Phone Number is always empty
    let fakePhoneNumber = "9999999999"
    guard let url = URL(string: "tel://\(fakePhoneNumber)") else { return }
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }
  
}
