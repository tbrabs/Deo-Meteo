//
//  LocationSearchDetail.swift
//  DeoMeteo
//
//  Created by Tristan on 20/12/2020.
//

import SwiftUI

struct LocationSearchDetail: View {
        
    @ObservedObject var favoriteVM = FavoriteViewModel()
    @Binding var isShowingDetail: Bool
    @Binding var wikiImageURLToDownload: String
    var locationWeather: LocationWeather
    
    var body: some View {
        VStack {
            
            LocationDayInfoView(locationWeather: locationWeather, wikiImageURLtoDownload: wikiImageURLToDownload)
            
            Button {
                favoriteVM.writeData(city: locationWeather.name)
                favoriteVM.isshowingAlert.toggle()
            } label: {
                Text("Save location")
                    .bold()
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color(.blue))
                    .cornerRadius(8)
                    .padding()
                    .padding(.bottom, -40)
            }
        }
//        .onAppear(perform: {
//            print(wikiImageURLToDownload)
//        })
        .frame(width: 300, height: 550)
        .background(Color("CellColor"))
        .cornerRadius(12)
        .shadow(radius: 10)
        .overlay(Button {
            isShowingDetail.toggle()
        } label: {
            XDimissButton()
        }, alignment: .topTrailing)
        //        .overlay(XDimissButton(), alignment: .topTrailing)
        .alert(item: $favoriteVM.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
        .alert(isPresented: $favoriteVM.isshowingAlert, content: {
            Alert(title: Text("Saved"),
                  message: Text("\(locationWeather.name) is now saved in your favorites!"),
                  dismissButton: .default(Text("OK")))
        })
    }
}

struct LocationSearchDetail_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchDetail(isShowingDetail: .constant(true), wikiImageURLToDownload: .constant("https://upload.wikimedia.org/wikipedia/commons/a/af/Arc_Triomphe_%28square%29.jpg"), locationWeather: LWMockData.dayInstance)
    }
}
