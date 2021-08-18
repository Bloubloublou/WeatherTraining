//
//  ApiManager.swift
//  WeatherTraining
//
//  Created by Bénédicte Lagouge on 12/07/2021.
//

import Foundation

class APIManager {
    
    static var shared = APIManager()
    
    private let baseURL = "https://api.openweathermap.org"
    
    private let apiKy = "7b5e590c39152ca6c17f04f0c32fd980"
    
    private let session = URLSession(configuration: .default)
    
    func askForWeather(cityName: String,completion: @escaping (Result<City, Error>) -> Void) {
        print(cityName)
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&APPID=\(apiKy)&units=metric")!

        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            
            // catching the case when cty is not found
            if(httpResponse?.statusCode == 404) {
                DispatchQueue.main.async { completion(.failure(APIError.notFound)) }
                return
            }
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data!, options : .allowFragments) as? Dictionary<String,Any>
                
                // filtering openweather info
                let cityJSON = self.getWeatherPreviews(name: cityName, json: jsonObject!)
               
                let filteredData =  try JSONSerialization.data(withJSONObject: cityJSON, options: JSONSerialization.WritingOptions.prettyPrinted)
                    
                let city = try JSONDecoder().decode(City.self, from: filteredData)
                
                DispatchQueue.main.async { completion(.success(city)) }
            } catch let error as NSError {
                print(error)
            }
        }
        task.resume()
    }

    private func getWeatherPreviews(name:String, json: Dictionary<String,Any>) -> Dictionary<String,Any>{
        
        var result = Dictionary<String,Any>()
        result["name"] = name
        
        var weathers:[Dictionary<String,Any>] = []
        
        let jsonArray = json["list"] as! [Dictionary<String, Any>]
        
        for json in jsonArray {
            var weatherJson = Dictionary<String,Any>()
            weatherJson["date"] = json["dt"]
            weatherJson["celsius_temperature"] = Int((json["main"] as! Dictionary<String,Any>)["temp"] as! Double)
            weatherJson["celsius_min_temperature"] = Int((json["main"] as! Dictionary<String,Any>)["temp_min"] as! Double)
            weatherJson["celsius_max_temperature"] = Int((json["main"] as! Dictionary<String,Any>)["temp_max"] as! Double)
            weatherJson["weather"] = ((json["weather"] as! [Dictionary<String,Any>])[0] as Dictionary<String,Any>)["main"]
            weatherJson["weather_description"] = ((json["weather"] as! [Dictionary<String,Any>])[0] as Dictionary<String,Any>)["description"]
            weatherJson["weather_icon"] = ((json["weather"] as! [Dictionary<String,Any>])[0] as Dictionary<String,Any>)["icon"]
            
            weathers.append(weatherJson)
        }
        
        result["weather_previews"] = weathers
        
        print(result)
        return result
    }
}

enum APIError: Error {
    case notFound
    case error(error: Error)
}
