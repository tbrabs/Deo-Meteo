//
//  ForecastsDayView.swift
//  DeoMeteo
//
//  Created by Tristan on 14/12/2020.
//

import SwiftUI

struct ForecastsDayCell: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var dayDT: String
    var dayTemp: Temp
    var dayWeather: Int
    
    //    var weather: WeatherResponse
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(colorScheme == .light ? Color(.systemBackground) : Color("CellColor"))
                .frame(height: 100)
                .shadow(radius: 3, x: 3, y: 3 )
            
            HStack {
                Text("\(dayDT)")
                    .fixedSize()
                    .padding(.leading)
                
                Spacer()
                
                HStack(spacing: 70) {
                    
                    HStack {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.blue)
                            Text("\(dayTemp.roundedMinTemp)°")
                        }
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.red)
                            Text("\(dayTemp.roundedMaxTemp)°")
                        }
                    }
                    TempLogoImage(conditionId: dayWeather)
                        .padding(.trailing)
                }
            }
        }
    }
}

struct ForecastsDayView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastsDayCell(dayDT: MockData.day1.formattedDailyDate, dayTemp: MockData.day1.temp, dayWeather: MockData.day1.weather.first?.id ?? 200)
    }
}
