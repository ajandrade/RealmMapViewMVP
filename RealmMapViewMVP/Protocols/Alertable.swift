//
//  Alertable.swift
//  RealmMapViewMVP
//
//  Created by Amadeu Andrade on 13/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

protocol Alertable { }

extension Alertable where Self: UIViewController {

  func showAlert(with message: String) {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
    alert.addAction(dismissAction)
    present(alert, animated: true, completion: nil)
  }
  
}
