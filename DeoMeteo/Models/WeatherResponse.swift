//
//  Weather.swift
//  DeoMeteo
//
//  Created by Tristan on 13/12/2020.
//

import Foundation


struct WeatherResponse: Decodable {
    let timezone: String
    let current: Current
    let daily: [Daily]
}

struct Current: Decodable {
    let temp: Double
    let dt: TimeInterval
    let weather: [Weather]
}

struct Daily: Decodable {
    let dt: TimeInterval
    let temp: Temp
    let weather: [Weather]
}

struct Weather: Decodable {
    let id: Int
}

struct Temp: Decodable {
    let min: Double
    let max: Double
}

struct MockData {
    
    static let dayInstance = WeatherResponse(timezone: "Chicago", current: Current(temp: 4.2, dt: 1607967800, weather: [Weather(id: 301)]), daily: [Daily(dt: 1607968800, temp: Temp(min: 3.5, max: 8.7), weather: [Weather(id: 203)])])

    static let day1 = Daily(dt: 1607968800, temp: Temp(min: 0, max: 5),
                            weather: [Weather(id: 189)])

    static let day2 = Daily(dt: 1607968800, temp: Temp(min: 0, max: 5),
                            weather: [Weather(id: 200)])

    static let day3 = Daily(dt: 1607968800, temp: Temp(min: 0, max: 5),
                            weather: [Weather(id: 180)])

    static let day4 = Daily(dt: 1607968800, temp: Temp(min: 0, max: 5),
                            weather: [Weather(id: 208)])

    static let day5 = Daily(dt: 1607968800, temp: Temp(min: 0, max: 5),
                            weather: [Weather(id: 320)])

    static let day6 = Daily(dt: 1607968800, temp: Temp(min: 0, max: 5),
                            weather: [Weather(id: 177)])

    static let day7 = Daily(dt: 1607968800, temp: Temp(min: 0, max: 5),
                            weather: [Weather(id: 260)])

    static let days = [day1, day2, day3, day4, day5, day6, day7 ]

}


