//
//  DetailedForecastViewController.swift
//  WeatherTraining
//
//  Created by Bénédicte Lagouge on 22/07/2021.
//

import UIKit

class DetailedForecastViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var currentDayCollectionView: UICollectionView!
    
    @IBOutlet weak var nextWeekTableView: UITableView!
    
    var city: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityNameLabel.text = city?.name
        weatherDescriptionLabel.text = city?.weatherPreviews[0].weatherDescription
        temperatureLabel.text = "\(city!.weatherPreviews[0].celsiusTemperature)"
        
        // init horizontal collection view
        currentDayCollectionView.dataSource = self
        currentDayCollectionView.register(UINib(nibName: "CurrentDayCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "currentDayCell")
        
        // init vertical table view
        nextWeekTableView.register(UINib(nibName: "NextDayTableViewCell", bundle: .main), forCellReuseIdentifier: "nextDayCell")
        
        nextWeekTableView.dataSource = self
    }
    
    private func getWeatherForeCastOfDay(day: String) -> [WeatherPreview] {
        var result: [WeatherPreview] = []
        
        city?.weatherPreviews.forEach({ weather in
            if(weather.date.toString() == day) {
                result.append(weather)
            }
        })
        
        /*for weather in city!.weatherPreviews {
            if(weather.date.toString() == day) {
                result.append(weather)
            }
        }*/
        
        return result
    }
    
    func getDayAfterFirstDay(after: Int) -> Date {
        let currentDay: Date = (city?.weatherPreviews[0].date)!
        
        var dateComponent = DateComponents()
        dateComponent.day = after
        
        return Calendar.current.date(byAdding: dateComponent, to: currentDay)!
    }
}

extension DetailedForecastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let currentDay = city!.weatherPreviews[0].date.toString()
        let weathersOfCurrentDay = self.getWeatherForeCastOfDay(day: currentDay)
        
        return weathersOfCurrentDay.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentDay = city!.weatherPreviews[0].date.toString()
        let weathersOfCurrentDay = self.getWeatherForeCastOfDay(day: currentDay)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "currentDayCell", for: indexPath) as! CurrentDayCollectionViewCell
        
        cell.configure(weatherForecast: weathersOfCurrentDay[indexPath.row])
        
        return cell
    }
}

extension DetailedForecastViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        var tmpDayStr = ""
        
        for forecast in city!.weatherPreviews {
            let dayStr = forecast.date.toString()
            if(tmpDayStr != dayStr) {
                count += 1
                tmpDayStr = dayStr
            }
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nextDayCell", for: indexPath) as! NextDayTableViewCell

        cell.configure(city: city!, day: getDayAfterFirstDay(after: indexPath.row))
        
        return cell
    }
}
