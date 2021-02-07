//
//  FavScreen.swift
//  DeoMeteo
//
//  Created by Tristan on 13/12/2020.
//

import SwiftUI
import CoreLocation

struct FavoriteView: View {
    
    @StateObject var favoriteVM = FavoriteViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(favoriteVM.favorite, id: \.self) { city in
                        FavoriteCellView(cityName: favoriteVM.getValue(obj: city)).onTapGesture {
                            favoriteVM.favCity = city.value(forKey: "city") as! String
                            favoriteVM.isShowingDetail = true
                        }
                    }
                    .onDelete(perform: { indexSet in
                        favoriteVM.deleteData(indexSet: indexSet)
                    })
                }
                .navigationTitle("⭐️ Favorites")
                .onAppear(perform: {
                    favoriteVM.isShowingDetail = false
                    favoriteVM.readData()
                })
                
                
            }
            .blur(radius: favoriteVM.isShowingDetail ? 8 : 0)
            .disabled(favoriteVM.isShowingDetail ? true : false)
            .alert(item: $favoriteVM.alertItem) { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: alertItem.dismissButton)
            }
            if favoriteVM.isShowingDetail {
                FavDetailView(viewModel: FavDetailViewModel(favCity: favoriteVM.favCity), isShowingDetail: $favoriteVM.isShowingDetail)
            }
            
            if favoriteVM.favorite.isEmpty {
                EmptyFavView()
            }
        }        
    }
}

struct FavScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
