//
//  City.swift
//  WeatherTraining
//
//  Created by Bénédicte Lagouge on 19/07/2021.
//

import Foundation

struct City: Codable {
    let name: String
    let weatherPreviews: [WeatherPreview]

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case weatherPreviews = "weather_previews"
    }
}
