//
//  LocationWeather.swift
//  DeoMeteo
//
//  Created by Tristan on 20/12/2020.
//

import Foundation
import SwiftUI

struct LocationWeather: Codable {
    let name: String
    let main: Main
    let weather: [LocationSearchWeather]
}

struct Main: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    
    //MARK: - Color Temp Circle
    
    var colorTemp: Color {
        switch temp {
        case ..<(-5.0):
            return Color("VeryCold")
        case -5.0..<0.0:
            return Color("Cold")
        case 0.0..<10.0:
            return Color("Fresh")
        case 10.0..<15.0:
            return Color("Mild")
        case 15.0..<25.0 :
            return Color("Warm")
        case 25.0..<35.0 :
            return Color("Hot")
        case 35.0...:
            return Color("BurningHot")
        default:
            return Color(.gray)
        }
    }
}

struct LocationSearchWeather: Codable {
    let id: Int
}

struct LWMockData {
    static let dayInstance = LocationWeather(name: "Beijing", main: Main(temp: 13.0, temp_min: 4.0, temp_max: 14.0), weather: [LocationSearchWeather(id: 605)])
}


