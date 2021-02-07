//
//  FavoriteViewModel.swift
//  DeoMeteo
//
//  Created by Tristan on 06/01/2021.
//

import SwiftUI
import CoreData

final class FavoriteViewModel: ObservableObject {
    
    @Published var favorite: [NSManagedObject] = []
    @Published var favCity          = ""
    @Published var wikiResponse     = ""
    @Published var isShowingDetail  = false
    @Published var isshowingAlert = false
    @Published var city             = ""
    @Published var alertItem: AlertItem?
    @Published var favoriteWeather: LocationWeather?
    let context = persistentContainer.viewContext
    
    
    let columns: [GridItem] = [GridItem(.flexible(), spacing: 20),
                               GridItem(.flexible(), spacing: 20),
                               GridItem(.flexible(), spacing: 20)]
        
    init() {
        readData()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    var selectedFavorite: NSManagedObject? {
        didSet {
            isShowingDetail = true
        }
    }
    
    
    //MARK: - Data Persistence with Core Data
    
    func readData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        
        do {
            let results = try context.fetch(request)
            self.favorite = results as! [NSManagedObject]
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func writeData(city: String) {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "Favorite", into: context)
        entity.setValue(city, forKey: "city")
        
        do {
            try context.save()
            // Si ça marche ça veut dire qu'on append bien à l'array
            self.favorite.append(entity)
            // Et on clear l'object city
            self.city = ""
        } catch {
            print(error.localizedDescription)
        }

    }
        
    func deleteData(indexSet: IndexSet) {
        for index in indexSet {
            do {
                let obj = favorite[index]
                context.delete(obj)
                try context.save()
                favorite.remove(at: index)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getValue(obj: NSManagedObject) -> String {
        return obj.value(forKey: "city") as! String
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
    
    
    //MARK: - Weather fetching
        
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
    
    //MARK: - Detail Fav View Networking
    
    func locationRequests() {
        let group = DispatchGroup()
        
        group.enter()
        NetworkManager.shared.getWikiImage(with: wikiUrlString) { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    wikiResponse = response.query.pages.the1.imageinfo[0].url
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
