//
//  XDimissButton.swift
//  DeoMeteo
//
//  Created by Tristan on 20/12/2020.
//

import SwiftUI

struct XDimissButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .opacity(0.7)
            Image(systemName: "xmark")
                .imageScale(.medium)
                .frame(width: 44, height: 44)
                .foregroundColor(Color.blue)
        }
    }
}

struct XDimissButton_Previews: PreviewProvider {
    static var previews: some View {
        XDimissButton()
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
