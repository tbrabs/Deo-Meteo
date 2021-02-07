//
//  HomeViewModel.swift
//  DeoMeteo
//
//  Created by Tristan on 19/12/2020.
//

import Foundation
import CoreLocation

final class HomeViewModel: ObservableObject {
    
    @Published var weather: WeatherResponse?
    @Published var locationWeather: LocationWeather?
    @Published var wikiResponse     = ""
    @Published var currentWikiPic   = ""
    @Published var conditionId: Int = 0
    @Published var alertItem: AlertItem?
    @Published var timeZone         = ""
    @Published var currentTime      = 0.0
    @Published var locationSearch   = ""
    @Published var isSearching      = false
    @Published var dateString       = ""
    @Published var isShowingDetail  = false
    @Published var daily: [Daily]   = []
    @Published var wikiImageLink    = ""
    @Published var currentLocationCity = ""
    @Published var isLoading        = false
    
    
    //MARK: - User Location Getter
    
    let locationManager = LocationManager()
    var latitude = CLLocationDegrees()
    var longitude = CLLocationDegrees()
    
    
    func locationHandling() {
        isLoading = true
        
        let group = DispatchGroup()
        
        group.enter()
        
        DispatchQueue.main.async {
            if self.locationManager.location != nil {
                let coordinate = self.locationManager.location?.coordinate
                self.latitude = coordinate!.latitude
                self.longitude = coordinate!.longitude
                self.getCurrentLocationWeather()
                self.locationManager.getLocationCityName(location: self.locationManager.location!) { locationName in
                    self.currentLocationCity = locationName ?? "Doha"
                    self.getCurrentLocationPic()
                    self.isLoading.toggle()
                }
            } else {
                print("erreur la loc est nil")
            }
        }
    }
    
    //MARK: - Weather Networking
    
    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric"
    
    var urlString: String {
        "\(weatherURL)&appid=\(K.openWeatherAPIKey)&q=\(locationSearch.trimmingCharacters(in: .whitespaces).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? locationSearch)"
    }
    
    let urlWeather = "https://api.openweathermap.org/data/2.5/onecall?exclude=minutely,hourly&units=metric&lang=fr"
    
    var gpsUrlWeather: String {
        "\(urlWeather)&lat=\(latitude)&lon=\(longitude)&appid=\(K.openWeatherAPIKey)"
    }
    
    public func getCurrentLocationWeather() {
        NetworkManager.shared.getWeather(with: gpsUrlWeather) { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    weather = response
                    conditionId = response.current.weather[0].id
                    timeZone = response.timezone
                    currentTime = response.current.dt
                    daily = response.daily
                    
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
        
    //MARK: - Wikipedia Image Networking
    
    let wikiImageURL = "https://en.wikipedia.org/w/api.php?action=query&generator=images&prop=imageinfo&iiprop=url&format=json"
    
    var wikiUrlString: String {
        "\(wikiImageURL)&titles=\(locationSearch.trimmingCharacters(in: .whitespaces).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? locationSearch)"
    }

    var currentWikiUrlString: String {
        "\(wikiImageURL)&titles=\(currentLocationCity.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? currentLocationCity)"
    }
    
    //MARK: - Group Network
    
    func locationRequests() {
        let group = DispatchGroup()
        
        group.enter()
        print("\(wikiUrlString)-----request")
        NetworkManager.shared.getWikiImage(with: wikiUrlString) { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    wikiResponse = response.query.pages.the4.imageinfo[0].url
                    print("la request marché")
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
                    locationWeather = response
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
    
    //MARK: - Get current location image
    
    func getCurrentLocationPic() {
        print(currentWikiUrlString)
        NetworkManager.shared.getWikiImage(with: currentWikiUrlString) { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    currentWikiPic = response.query.pages.the1.imageinfo[0].url
                    isLoading = false
                    print("ça marche pourtant")
                    print(currentWikiPic)
                case .failure(let error):
                    print("ça marhce pas......")
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
