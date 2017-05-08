//
//  File.swift
//  RainyShiny
//
//  Created by Nicolas Maltais on 5/1/17.
//  Copyright © 2017 Nicolas Maltais. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: String!
    private var _lowTemp: String!
    
    var date: String {
        get {
            if _date == nil{
                _date = ""
            }
            return _date
        }
        set {
            _date = newValue
        }
    }
    
    var weatherType: String {
        get {
            if _weatherType == nil{
                _weatherType = ""
            }
            return _weatherType
        }
        set {
            _weatherType = newValue
        }
        
    }
    
    var highTemp: String {
        get {
            if _highTemp == nil{
                _highTemp = ""
            }
            return _highTemp
        }
        set {
            _highTemp = newValue
        }
        
    }
    
    var lowTemp: String {
        get {
            if _lowTemp == nil{
                _lowTemp = ""
            }
            return _lowTemp
        }
        set {
            _lowTemp = newValue
        }
    }
    
    init(weatherDict: Dictionary<String, AnyObject>){
       //print(weatherDict)
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject>{
            if let min_temp = temp["min"] as? Double{
                self._lowTemp = "\(round(9/5 * (min_temp - 273) + 32))"
            }
            if let max_temp = temp["max"] as? Double{
                self._highTemp = "\(round(9/5 * (max_temp - 273) + 32))"
            }
        }
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>]{
            
            if let weatherType = weather[0]["main"] as? String{
                print(weatherType)
                self._weatherType = weatherType
            }
        }
        
        if let date = weatherDict["dt"] as! Double?{
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = dateFormatter.string(from: unixConvertedDate/*.addingTimeInterval(86400)*/)
        }

    }
    
}
