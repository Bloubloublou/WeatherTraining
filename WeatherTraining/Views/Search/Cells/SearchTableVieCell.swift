//
//  SearchTableVieCell.swift
//  WeatherTraining
//
//  Created by Bénédicte Lagouge on 21/07/2021.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var cityName: String?
    
    func configure(_ cityName: String) {
        self.cityName = cityName
        cityNameLabel.text = cityName
    }
}
