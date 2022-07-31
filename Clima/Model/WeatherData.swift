//
//  WeatherData.swift
//  Clima
//
//  Created by Griffin Reding on 7/29/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    public let name: String
    public let main: Main
    public let weather: [Weather]
}

struct Main: Codable {
    public let temp: Double
    public let temp_min: Double
    public let temp_max: Double
}

struct Weather: Codable {
    public let id: Int
    public let main: String
    public let description: String
    public let icon: String
}
