//
//  favDetailView.swift
//  DeoMeteo
//
//  Created by Tristan on 27/01/2021.
//

import SwiftUI

struct FavDetailView: View {
    
    @ObservedObject var viewModel: FavDetailViewModel
    @Binding var isShowingDetail: Bool
    
    var body: some View {
        VStack {
            LocationDayInfoView(locationWeather: viewModel.favoriteWeather ??  LWMockData.dayInstance, wikiImageURLtoDownload: viewModel.wikiResponse)
        }
        .frame(width: 300, height: 450)
        .background(Color("CellColor"))
        .cornerRadius(12)
        .shadow(radius: 10)
        .overlay(Button {
            isShowingDetail = false
        } label: {
            XDimissButton()
        }, alignment: .topTrailing)
        //        .overlay(XDimissButton(), alignment: .topTrailing)
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
        .onAppear(perform: {
            viewModel.locationRequests()
        })
    }
}

struct favDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FavDetailView(viewModel: FavDetailViewModel(favCity: "Doha"), isShowingDetail: .constant(false))
    }
}
