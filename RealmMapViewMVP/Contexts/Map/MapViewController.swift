//
//  MapViewController.swift
//  RealmMapViewMVP
//
//  Created by Amadeu Andrade on 12/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit
import MapKit
import RealmMapView
import RealmSwiftSFRestaurantData

class MapViewController: UIViewController, Alertable {
  
  // MARK: - DEPENDENCIES
  
  var presenter: MapPresenterRepresentable!
  
  // MARK: - IBOUTLETS

  @IBOutlet private weak var mapView: RealmMapView! {
    didSet { mapView.realmConfiguration = presenter.realmConfiguration }
  }

  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.didUpdateAuthorization = { [weak self] result in
      switch result {
      case .success:
        break
      case .failure(let error):
        self?.showAlert(with: error.description)
      }
    }
    
    presenter.didUpdateUserLocation = { [weak self] result in
      switch result {
      case .success(let userLocation):
        self?.mapView.center(on: userLocation, withRadius: 2000)
      case .failure(let error):
        self?.showAlert(with: error.description)
      }
    }
  }
  
  // MARK: - IBACTIONS
  
  @IBAction func onMyLocationPressed(_ sender: UIButton) {
    presenter.requestUserLocation()
  }
  
}

extension MapViewController: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    guard !(view.annotation is MKUserLocation) else { return }
    
    let selectedAnnotation = view.annotation as! Annotation
    
    switch selectedAnnotation.type {
    case .unique:
      if let safeObjects = ClusterAnnotationView.safeObjects(forClusterAnnotationView: view) {
        if let restaurant = safeObjects.first?.rlmObject() as? ABFRestaurantObject {
          presenter.showDetails(for: restaurant)
        }
      }
    case .cluster:
      break
    }
  }
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard let fetchedAnnotation = annotation as? Annotation else { return nil }
    
    guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier) as? CustomAnnotationView else {
      return CustomAnnotationView.new(with: fetchedAnnotation)
    }
    
    return annotationView.update(with: fetchedAnnotation)
  }

}
