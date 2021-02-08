//
//  LocationDayInfoView.swift
//  DeoMeteo
//
//  Created by Tristan on 24/12/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct LocationDayInfoView: View {
    
    var locationWeather: LocationWeather
    var wikiImageURLtoDownload = ""
    
    var body: some View {
        VStack(alignment: .center) {
            
            WebImage(url: URL(string: wikiImageURLtoDownload))
            .placeholder(Image("City_Empty").resizable())
            .resizable()
            .indicator(.activity)
            .animation(.easeInOut(duration: 0.5))
//                .animation(.linear)
            .aspectRatio(contentMode: .fit)
            .frame(width: 290, height: 290)
            
            
            Text(locationWeather.name)
            .font(.title)
            .fontWeight(.semibold)
            
            HStack {
                Text("\(locationWeather.main.roundedTemp)°")
                    .fixedSize()
                    .padding(.leading)
                
                Spacer()
                
                HStack(alignment: .center ,spacing: 45) {
                    HStack {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.blue)
                            Text("\(locationWeather.main.roundedMinTemp)°")
                        }
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.red)
                            Text("\(locationWeather.main.roundedMaxTemp)°")
                        }
                        
                    }
                    TempLogoImage(conditionId: locationWeather.weather[0].id)
                        .padding(.trailing)
                }
            }
        }
    }
}

struct LocationDayInfoView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDayInfoView(locationWeather: LWMockData.dayInstance)
    }
}
