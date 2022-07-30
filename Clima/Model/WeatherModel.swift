//
//  WeatherModel.swift
//  Clima
//
//  Created by Griffin Reding on 7/30/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
//    computed property
//    var aProperty: Int {
//        Something that provides output, that aProperty will be set to
//    }
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionID {
            case 200...232:
                return "cloud.bolt.rain"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.drizzle"
            case 600...622:
                return "cloud.drizzle"
            case 700...781:
                return "cloud.fog"
            case 800:
                return "sun.and.horizon"
            case 801...804:
                return "cloud.sun"
            default:
                return "cloud"
        }
    }
}
