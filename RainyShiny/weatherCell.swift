//
//  weatherCell.swift
//  RainyShiny
//
//  Created by Nicolas Maltais on 4/25/17.
//  Copyright © 2017 Nicolas Maltais. All rights reserved.
//

import UIKit

class weatherCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(){
        
        //Color shift
        if self.tag % 2 == 0{
            self.backgroundColor = UIColor.init(red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
        }
        else{
            self.backgroundColor = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        }
    }

}
