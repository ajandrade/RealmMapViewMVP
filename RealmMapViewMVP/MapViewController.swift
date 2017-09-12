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

class MapViewController: UIViewController {
  
  // MARK: - DEPENDENCIES
  
  var presenter: MapPresenterRepresentable!
  
  // MARK: - IBOUTLETS

  @IBOutlet private weak var mapView: RealmMapView! {
    didSet { mapView.realmConfiguration = RealmConfig.main.configuration }
  }

  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}

extension MapViewController: MKMapViewDelegate {

  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard let fetchedAnnotation = annotation as? Annotation else { return nil }
    
    guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier) as? CustomAnnotationView else {
      return CustomAnnotationView.new(with: fetchedAnnotation)
    }
    
    return annotationView.update(with: fetchedAnnotation)
  }

}
