//
//  EmptyState.swift
//  DeoMeteo
//
//  Created by Tristan on 17/12/2020.
//

import SwiftUI

struct EmptyState: View {

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("empty-order-2")
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

struct EmptyState_Previews: PreviewProvider {
    static var previews: some View {
        EmptyState()
    }
}
