//
//  DayInfoView.swift
//  DeoMeteo
//
//  Created by Tristan on 19/12/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct DayInfoView: View {

    var weather: WeatherResponse
    var wikiImageURLtoDownload: String
    var locationCity: String
    
    var body: some View {
        VStack {
            
            
            WebImage(url: URL(string: wikiImageURLtoDownload))
                .placeholder(Image("City_Empty").resizable())
                .resizable()
                .indicator(.activity)
                .animation(.easeInOut(duration: 0.5))
                .transition(.fade(duration: 0.5))
                .aspectRatio(contentMode: .fit)
                .frame(width: 290, height: 290)

            
            Text(locationCity)
                .font(.title)
                .fontWeight(.semibold)
                
            HStack(spacing: 70) {
                Text("\(weather.current.roundedTemp)°")
                Text("\(weather.current.formattedCurrentDate)")
                TempLogoImage(conditionId: weather.current.weather[0].id)
            }
        }
    }
}

struct DayInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DayInfoView(weather: MockData.dayInstance, wikiImageURLtoDownload: "4147|Bali_moped_col.jpg", locationCity: "Doha")
    }
}


