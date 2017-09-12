//
//  CustomAnnotationView.swift
//  RealmMapViewMVP
//
//  Created by Amadeu Andrade on 12/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit
import ABFRealmMapView

class CustomAnnotationView: ABFClusterAnnotationView, Identifiable {
  
  // MARK: - CONFIGURATION
  
  static func new(with annotation: ABFAnnotation) -> CustomAnnotationView {
    let newAnnotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.identifier)
    newAnnotationView.count = UInt(annotation.safeObjects.count)
    newAnnotationView.color = UIColor(hex: "3C5193")
    
    switch annotation.type {
    case .cluster:
      newAnnotationView.countLabel.isHidden = false
    case .unique:
      newAnnotationView.countLabel.isHidden = true
    }
    
    newAnnotationView.annotation = annotation
    
    return newAnnotationView
  }
  
  func update(with annotation: ABFAnnotation) -> CustomAnnotationView {
    self.count = UInt(annotation.safeObjects.count)
    self.annotation = annotation
    switch annotation.type {
    case .cluster:
      self.countLabel.isHidden = false
    case .unique:
      self.countLabel.isHidden = true
    }
    
    return self
  }
  
  
}
