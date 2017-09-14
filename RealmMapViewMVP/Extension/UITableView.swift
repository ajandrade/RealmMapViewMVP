//
//  UITableView.swift
//  RealmMapViewMVP
//
//  Created by Amadeu Andrade on 14/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import UIKit

extension UITableView {
  
  func register<T: UITableViewCell>(_: T.Type) where T: Identifiable {
    let nib = UINib(nibName: T.identifier, bundle: nil)
    register(nib, forCellReuseIdentifier: T.identifier)
  }
  
  func dequeueCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: Identifiable {
    guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
      fatalError("Could not dequeuce cell with id: \(T.identifier)")
    }
    return cell
  }
  
}
