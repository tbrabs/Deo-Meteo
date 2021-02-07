//
//  GradientView.swift
//  DeoMeteo
//
//  Created by Tristan on 01/02/2021.
//

import SwiftUI

struct GradientView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [colorScheme == .dark ? .red : .blue, colorScheme == .light ? .gray : Color("BlueGradient")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
    }
}

struct GradientView_Previews: PreviewProvider {
    static var previews: some View {
        GradientView()
    }
}
