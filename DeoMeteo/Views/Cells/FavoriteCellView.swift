//
//  FavoriteLocationView.swift
//  DeoMeteo
//
//  Created by Tristan on 06/01/2021.
//

import SwiftUI
import CoreData

struct FavoriteCellView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = FavoriteViewModel()
    var cityName: String
    var cityObjToRemove: NSManagedObject?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(colorScheme == .light ? Color(.systemBackground) : Color("CellColor"))
                .frame(height: 100)
                .shadow(radius: 3, x: 3, y: 3 )

                HStack {
                    Text(cityName)
                        .padding()
                    
                    Spacer()
                    
                    HStack(spacing: 85) {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(viewModel.favoriteWeather?.main.colorTemp)
                            Text("\(viewModel.favoriteWeather?.main.roundedTemp ?? 33)°")
                                .foregroundColor(Color(.systemBackground))
                        }
                        
                        TempLogoImage(conditionId: viewModel.favoriteWeather?.weather[0].id ?? 300)
                            .padding(.trailing)
                    }
                }
        }
        .padding(.all, 10)
        .cornerRadius(20)
        .onAppear {
            viewModel.favCity = cityName
            viewModel.locationWeatherRequest()
        }
    }
}

struct FavoriteLocationView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCellView(viewModel: FavoriteViewModel(), cityName: "Doha")
    }
}
