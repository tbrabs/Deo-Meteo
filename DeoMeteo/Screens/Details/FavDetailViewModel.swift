//
//  FavDetailViewModel.swift
//  DeoMeteo
//
//  Created by Tristan on 28/01/2021.
//

import Foundation
import SwiftUI

final class FavDetailViewModel: ObservableObject {
    
    @Published var alertItem: AlertItem?
    @Published var favoriteWeather: LocationWeather?
    @Published var wikiResponse = ""
    var favCity: String
    
    init(favCity: String) {
        self.favCity = favCity
    }
    
        
    //MARK: - URLs
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric"
    
    var urlString: String {
        "\(weatherURL)&q=\(favCity.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? favCity)&appid=\(K.openWeatherAPIKey)"
    }
    
    let wikiImageURL = "https://en.wikipedia.org/w/api.php?action=query&generator=images&prop=imageinfo&iiprop=url&format=json"
    
    var wikiUrlString: String {
        "\(wikiImageURL)&titles=\(favCity.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? favCity)"
    }
    
    //MARK: - Getting weather and wiki image
    
    func locationRequests() {
        let group = DispatchGroup()
        
        group.enter()
        print(wikiUrlString)
        NetworkManager.shared.getWikiImage(with: wikiUrlString) { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    wikiResponse = response.query.pages.the4.imageinfo[0].url
                    print("c'est ça que SD doit DL \(wikiResponse)")
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
        group.leave()
        
        group.enter()
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
        group.leave()
        
        group.notify(queue: .main) {}
        
    }
}
