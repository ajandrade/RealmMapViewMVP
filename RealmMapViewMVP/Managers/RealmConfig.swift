//
//  RealmConfig.swift
//  RealmMapViewMVP
//
//  Created by Amadeu Andrade on 12/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import RealmSwift
import RealmSwiftSFRestaurantData

enum RealmConfig {
  case defaultConfiguration
  case main
  
  var configuration: Realm.Configuration {
    switch self {
    case .defaultConfiguration:
      return Realm.Configuration.defaultConfiguration
    case .main:
      var config = Realm.Configuration.defaultConfiguration
      config.fileURL = URL(string: ABFRestaurantScoresPath())!
      return config
    }
  }
  
}
