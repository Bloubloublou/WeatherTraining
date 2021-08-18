//
//  UserDefaultsManager.swift
//  WeatherTraining
//
//  Created by Bénédicte Lagouge on 22/07/2021.
//

import Foundation

class UserDefaultsManager {
    static var shared = UserDefaultsManager()
    static let forecastKey = "forecasts"
    
    func addCity(_ newCity: City) {
        var cities = getAllCities()
        
        for city in cities {
            if(city.name == newCity.name) {
                return
            }
        }
        
        cities.append(newCity)
        
        saveCities(cities)
    }
    
    func updateCity(_ newCity: City) {
        var cities = getAllCities()
        
        for i in 0...cities.count-1 {
            if(cities[i].name == newCity.name) {
                cities[i] = newCity
            }
        }
        
        saveCities(cities)
    }
    
    func getAllCities() -> [City]{
        var result: [City] = []
        let decoded  = UserDefaults.standard.object(forKey: UserDefaultsManager.forecastKey) as! Data?
        
        do {
            if(decoded != nil) {
                result = try JSONDecoder().decode([City].self, from: decoded!)
            }
            
            return result
        } catch {
            print(error)
            return []
        }
    }
    
    private func saveCities(_ cities: [City]) {
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(cities)
            
             UserDefaults.standard.set(jsonData, forKey: UserDefaultsManager.forecastKey)
        } catch {
            print(error)
        }
    }
}
