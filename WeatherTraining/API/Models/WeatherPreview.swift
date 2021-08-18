//
//  WeatherPreview.swift
//  WeatherTraining
//
//  Created by Bénédicte Lagouge on 19/07/2021.
//

import Foundation

struct WeatherPreview: Codable {
    let date: Date
    let celsiusTemperature: Int
    let minTemperature: Int
    let maxTemperature: Int
    let weather: String
    let weatherDescription: String
    let weatherIcon: String

    enum CodingKeys: String, CodingKey {
        case date = "date"
        case celsiusTemperature = "celsius_temperature"
        case minTemperature = "celsius_min_temperature"
        case maxTemperature = "celsius_max_temperature"
        case weather = "weather"
        case weatherDescription = "weather_description"
        case weatherIcon = "weather_icon"
    }
}

extension WeatherPreview {
    func getAssociatedBigImageName() -> String{
        if(weatherIcon.contains("01")) {
            return "sun"
        }
        else if(weatherIcon.contains("02")) {
            return ""
        }
        else if(weatherIcon.contains("03")) {
            return ""
        }
        else if(weatherIcon.contains("04")) {
            return ""
        }
        else if(weatherIcon.contains("09")) {
            return ""
        }
        else if(weatherIcon.contains("10")) {
            return ""
        }
        else if(weatherIcon.contains("11")) {
            return ""
        }
        else if(weatherIcon.contains("13")) {
            return ""
        }
        else {
            return ""
        }
    }
}
