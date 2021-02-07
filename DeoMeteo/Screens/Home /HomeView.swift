//
//  ContentView.swift
//  DeoMeteo
//
//  Created by Tristan on 13/12/2020.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        
        ZStack {
            NavigationView {
                ZStack {
                    GradientView()
                    ScrollView {
                                VStack {
                                    
                                    SearchBar(searchLocation: $viewModel.locationSearch, isSearching: $viewModel.isSearching, function: onCommit).keyboardType(.webSearch)
                                        .padding(.top, 10)
                                    
                                    DayInfoView(weather: viewModel.weather ?? MockData.dayInstance, wikiImageURLtoDownload: viewModel.currentWikiPic, locationCity: viewModel.currentLocationCity)
                                    
                                    
                                    ForEach(viewModel.daily, id: \.dt) { day in
                                        ForecastsDayCell(dayDT: day.formattedDailyDate, dayTemp: day.temp, dayWeather: day.weather.first?.id ?? 200)
                                            //                                .padding(.vertical, 6)
                                            
                                            .padding(.horizontal)
                                            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                                    }
                                    .navigationTitle("🧭 \(viewModel.currentLocationCity)")
                                }
                    }
                }
            }
            .blur(radius: viewModel.isShowingDetail ? 8 : 0)
            .disabled(viewModel.isShowingDetail ? true : false)
            .onAppear() {
                viewModel.locationHandling()
                viewModel.isShowingDetail = false
            }
            if viewModel.isLoading {
                LoadingView()
            }
            
            if viewModel.isShowingDetail {
                LocationSearchDetail(isShowingDetail: $viewModel.isShowingDetail, wikiImageURLToDownload: $viewModel.wikiResponse, locationWeather: viewModel.locationWeather ?? LWMockData.dayInstance)
            }
        }
            
    }
    func onCommit() {
        viewModel.isShowingDetail = true
        viewModel.locationRequests()
        viewModel.locationSearch = ""
        viewModel.isSearching.toggle()
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}
