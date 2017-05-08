//
//  Location.swift
//  RainyShiny
//
//  Created by Nicolas Maltais on 5/5/17.
//  Copyright © 2017 Nicolas Maltais. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init(){
        self.latitude = 0
        self.longitude = 0
    }
    
    var latitude: Double
    var longitude: Double
}
