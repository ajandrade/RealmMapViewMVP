//
//  MapPresenter.swift
//  RealmMapViewMVP
//
//  Created by Amadeu Andrade on 12/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation
import RealmSwift

protocol MapPresenterRepresentable {
  var realmConfiguration: Realm.Configuration { get }
}

class MapPresenter: MapPresenterRepresentable {

  let realmConfiguration = RealmConfig.main.configuration
  
  init() {
  
  }
  
}
