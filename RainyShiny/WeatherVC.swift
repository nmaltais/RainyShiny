//
//  WeatherVC.swift
//  RainyShiny
//
//  Created by Nicolas Maltais on 4/22/17.
//  Copyright © 2017 Nicolas Maltais. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var manager: CLLocationManager!
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast = [Forecast]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        manager =  CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            manager.startMonitoringSignificantLocationChanges()
            currentLocation = manager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather = CurrentWeather()
            currentWeather.downloadWeatherInfo {
                self.downloadForecastData {
                    //Load data into the UI
                    self.updateMainUI()
                }
            }
        }
        else {
            manager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    

    func downloadForecastData(completed: @escaping () -> ()) {
        //Downloading forecast data fot TableView
        
        let forecastURL =  URL(string: FORECAST_WEATHER_API_CALL_URL)!
        
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]{
                    for item in list{
                        let currentForecastItem = Forecast(weatherDict: item)
                        self.forecast.append(currentForecastItem)
                    }
                    self.forecast.remove(at: 0) //Removes current day from the forecast list
                    self.tableView.reloadData()
                }
            }
            
            completed()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! weatherCell
        cell.tag = indexPath.row
        cell.updateUI(forecast: forecast[indexPath.row])
        
        return cell
    }
    
    func updateMainUI() {
        currentDateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.temperature)°F"
        currentWeatherLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
    
}

