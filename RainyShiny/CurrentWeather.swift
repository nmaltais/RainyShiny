//
//  CurrentWeather.swift
//  RainyShiny
//
//  Created by Nicolas Maltais on 4/25/17.
//  Copyright © 2017 Nicolas Maltais. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather{
    private var _date : String!
    private var _cityName : String!
    private var _temperature : Double!
    private var _weatherType : String!
    
    var date : String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
    
        return "Today, \(currentDate)"
    }
    
    var cityName : String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var temperature : Double {
        if _temperature == nil {
            _temperature = 0.0
        }
        return _temperature
    }
    
    var weatherType : String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    func downloadWeatherInfo(completed: @escaping () -> () ){
        print("starting download")
        let currentWeatherURL = URL(string: API_CALL_URL)!
        //Alamofire Download info
        Alamofire.request(currentWeatherURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let cityName = dict["name"] as? String {
                    self._cityName = cityName.capitalized
                }
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let type = weather[0]["main"] as? String {
                        self._weatherType = type.capitalized
                    }
                }
                if let temperatureKelvin = dict["main"]?["temp"] as? Double{
                    self._temperature = 9/5 * (temperatureKelvin - 273) + 32
                }
            }
            
            completed()
        }
    }
}
