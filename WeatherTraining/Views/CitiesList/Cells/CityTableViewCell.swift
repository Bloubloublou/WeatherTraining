//
//  CityCell.swift
//  WeatherTraining
//
//  Created by Bénédicte Lagouge on 19/07/2021.
//
import UIKit

protocol CityTableViewCellDelegate: AnyObject {
    func isCelsiusSelected() -> Bool
}

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var cellBackground: UIImageView!
    
    weak var delegate: CityTableViewCellDelegate?
    
    var city: City?
    
    func configure(_ city: City) {
        self.city = city
        
        let currentWeather = city.weatherPreviews[0]
        
        hourLabel.text = currentWeather.date.timeIn24HourFormat()
        
        nameLabel.text = city.name

        if((delegate?.isCelsiusSelected())!) {
            currentTemperatureLabel.text = String(currentWeather.celsiusTemperature)+"°"
        } else {
            currentTemperatureLabel.text = String(currentWeather.celsiusTemperature*9/5+32)+"°"
        }
        
        let imageName = currentWeather.getAssociatedBigImageName()
        cellBackground.image = UIImage(named: imageName)

    }
}
