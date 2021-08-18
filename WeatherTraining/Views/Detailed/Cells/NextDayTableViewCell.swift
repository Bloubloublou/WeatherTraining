//
//  NextDayTableViewCell.swift
//  WeatherTraining
//
//  Created by Bénédicte Lagouge on 23/07/2021.
//

import UIKit

class NextDayTableViewCell: UITableViewCell{
    
    @IBOutlet weak var dayNameLabel: UILabel!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    
    @IBOutlet weak var minTemperatureLabel: UILabel!
    
    func configure(city: City, day: Date) {
        let weatherForecasts = city.weatherPreviews
        
        var min = weatherForecasts[0].minTemperature
        var max = weatherForecasts[0].maxTemperature
        for forecast in weatherForecasts {
            if(forecast.date.toString() == day.toString()) {
                if(min > forecast.minTemperature) {
                    min = forecast.minTemperature
                }
            }
            
            if(forecast.date.toString() == day.toString()) {
                if(max < forecast.maxTemperature) {
                    max = forecast.maxTemperature
                }
            }
        }
        
        dayNameLabel.text = day.getHumanReadableDayString()
        maxTemperatureLabel.text = "\(max)"
        minTemperatureLabel.text = "\(min)"
    }
}
