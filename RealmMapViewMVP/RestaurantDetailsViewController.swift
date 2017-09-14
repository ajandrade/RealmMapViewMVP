//
//  RestaurantDetailsViewController.swift
//  RealmMapViewMVP
//
//  Created by Amadeu Andrade on 14/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailsViewController: UIViewController {
  
  // MARK: - DEPENDENCIES
  
  var presenter: RestaurantDetailsPresenterRepresentable!
  
  // MARK: - IBOUTLETS
  
  @IBOutlet private weak var mapView: MKMapView!
  @IBOutlet private weak var restaurantNameLabel: UILabel!
  @IBOutlet private weak var restaurantAddressLabel: UILabel!
  @IBOutlet private weak var restaurantCityLabel: UILabel!
  @IBOutlet private weak var restaurantPhoneLabel: UILabel!
  @IBOutlet private weak var restaurantRatingLabel: UILabel!
  @IBOutlet private weak var phoneButton: UIButton!
  
  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
    restaurantNameLabel.text = presenter.restaurantName
    restaurantAddressLabel.text = presenter.restaurantAddress
    restaurantCityLabel.text = presenter.restaurantCity
    restaurantPhoneLabel.text = presenter.restaurantPhone
    restaurantRatingLabel.text = presenter.restaurantRating
    phoneButton.isEnabled = presenter.phoneEnabled
    setMapPin()
  }
  
  // MARK: - IBACTIONS
  
  @IBAction func onPhonePressed(_ sender: UIButton) {
    presenter.phonePressed()
  }
  
  // MARK: - METHODS
  
  private func setMapPin() {
    let annotation = MKPointAnnotation()
    annotation.coordinate = presenter.restaurantCoordinates
    mapView.addAnnotation(annotation)
    let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 250, 250)
    self.mapView.setRegion(region, animated: false)
  }
  
}

extension RestaurantDetailsViewController: MKMapViewDelegate {

  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    return CustomAnnotationView.staticAnnotation(from: annotation)
  }
  
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

  }
  
}
