//
//  Constants.swift
//  RainyShiny
//
//  Created by Nicolas Maltais on 4/25/17.
//  Copyright © 2017 Nicolas Maltais. All rights reserved.
//

import Foundation

let COUNT = 10

let LAT = Location.sharedInstance.latitude

let LON = Location.sharedInstance.longitude

let API_KEY = "9bf72caa73c5bbb9437ac0e2ae8d7ae0"

let CURRENT_WEATHER_API_CALL_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(LAT)&lon=\(LON)&appid=\(API_KEY)"


let FORECAST_WEATHER_API_CALL_URL =  "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(LAT)&lon=\(LON)&cnt=\(COUNT)&appid=\(API_KEY)"
