//
//  CitiesManager.swift
//  WeatherTraining
//
//  Created by Bénédicte Lagouge on 22/07/2021.
//

import Foundation

class CitiesManager {
    static var shared = CitiesManager()
    
    func updateAllCities() {
        let cities = UserDefaultsManager.shared.getAllCities()
        
        for city in cities {
            APIManager.shared.askForWeather(cityName: city.name) {result in switch(result) {
            case .success(let newCity):
                UserDefaultsManager.shared.updateCity(newCity)
            case .failure(let error):
                print(error)
                }
            }
        }
    }
    
    func getCities() -> [City] {
        return UserDefaultsManager.shared.getAllCities()
    }
    
    func addCity(cityName: String) {
        APIManager.shared.askForWeather(cityName: cityName) {result in switch(result) {
        case .success(let newCity):
            UserDefaultsManager.shared.addCity(newCity)
        case .failure(let error):
            print(error)
            }
        }
    }
    
}

