//
//  CurrentDayCollectionViewCell.swift
//  WeatherTraining
//
//  Created by Bénédicte Lagouge on 23/07/2021.
//

import UIKit

class CurrentDayCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var hourLabel: UILabel!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func configure(weatherForecast: WeatherPreview) {
        hourLabel.text = weatherForecast.date.getHour()
        weatherImageView.image = UIImage(named: weatherForecast.weatherIcon)
        temperatureLabel.text = "\(weatherForecast.celsiusTemperature)"
    }
}
