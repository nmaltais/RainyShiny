//
//  weatherCell.swift
//  RainyShiny
//
//  Created by Nicolas Maltais on 4/25/17.
//  Copyright © 2017 Nicolas Maltais. All rights reserved.
//

import UIKit

class weatherCell: UITableViewCell {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(forecast: Forecast){
        
        //BGColor alternate
        if self.tag % 2 == 0{
            self.backgroundColor = UIColor.init(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        }
        else{
            self.backgroundColor = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        }
        
        date.text = forecast.date
        weatherType.text = forecast.weatherType
        highTemp.text = forecast.highTemp + "°F"
        lowTemp.text = forecast.lowTemp + "°F"
        weatherImage.image = UIImage(named: forecast.weatherType)
        
    }

}
