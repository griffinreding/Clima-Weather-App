//
//  weatherManager.swift
//  Clima
//
//  Created by Griffin Reding on 7/28/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=114080b2adf11aa8398adeefd61730d2&units=imperial"
    
    func fetchWeather(_ cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        let cleanedUrlString = urlString.replacingOccurrences(of: " ", with: "%20")
        performRequest(with: cleanedUrlString)
    }
    
    func fetchWeather(_ lat: CLLocationDegrees, _ lon: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        let cleanedUrlString = urlString.replacingOccurrences(of: " ", with: "%20")
        performRequest(with: cleanedUrlString)
    }
    
    func performRequest(with urlString: String) {

        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temperature = decodedData.main.temp
            let tempLow = decodedData.main.temp_min
            let tempHigh = decodedData.main.temp_max
            let cityName = decodedData.name
            let weather = WeatherModel(conditionID: id, cityName: cityName, temperature: temperature, tempLow: tempLow, tempHigh: tempHigh)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
