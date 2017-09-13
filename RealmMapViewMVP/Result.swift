//
//  Result.swift
//  RealmMapViewMVP
//
//  Created by Amadeu Andrade on 13/09/2017.
//  Copyright © 2017 Amadeu Andrade. All rights reserved.
//

import Foundation

enum Result<T> {
  case success(T)
  case failure(LocationError)
}
