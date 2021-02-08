//
//  EmptyFavView.swift
//  DeoMeteo
//
//  Created by Tristan on 31/01/2021.
//

import SwiftUI

struct EmptyFavView: View {
        
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("City_Empty")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                Text("No favorites saved!")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding()
            }
            .offset(y: -50)
        }
    }
}

struct EmptyFavView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyFavView()
    }
}
