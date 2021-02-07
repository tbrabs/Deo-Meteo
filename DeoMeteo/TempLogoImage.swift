//
//  SwiftUIView.swift
//  DeoMeteo
//
//  Created by Tristan on 23/12/2020.
//

import SwiftUI

struct TempLogoImage: View {
    
    var conditionId: Int
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    var body: some View {
        Image(systemName: conditionName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
    }
}

struct TempLogoImage_Previews: PreviewProvider {
    static var previews: some View {
        TempLogoImage(conditionId: 605)
    }
}
