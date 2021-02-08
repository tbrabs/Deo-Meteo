//
//  TabBar.swift
//  DeoMeteo
//
//  Created by Tristan on 13/12/2020.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
            
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            FavoriteView()
                .tabItem {
                    Image(systemName: "star")
                    Text("Favorites")
                }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
