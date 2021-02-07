//
//  FavCellViewModel.swift
//  DeoMeteo
//
//  Created by Tristan on 28/01/2021.
//

import Foundation
import SwiftUI

final class FavCellViewModel: ObservableObject {
    
    @Published var alertItem: AlertItem?
    var favCity = ""
    var favoriteWeather: LocationWeather?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric&appid=cdb7a21055e18d76a02034fd826852d7"
    
    var urlString: String {
        "\(weatherURL)&q=\(favCity)"
    }
    
    func locationWeatherRequest() {
        NetworkManager.shared.getLocationWeather(with: urlString) { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    favoriteWeather = response
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
}
