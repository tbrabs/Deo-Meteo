//
//  SearchBar.swift
//  DeoMeteo
//
//  Created by Tristan on 13/12/2020.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchLocation: String
    @Binding var isSearching: Bool
    var function: () -> Void
    
    var body: some View {
        HStack {
            HStack {
                TextField("Indicate a location", text: $searchLocation, onCommit: function)
                    .padding(.leading, 23)
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(8)
            .padding(.horizontal)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    
                    if isSearching {
                        Button(action: {
                            searchLocation = ""
                        }, label: {
                            Image(systemName: "xmark")
                        })
                        .padding(.vertical)
                    }
                    
                }
                .padding(.horizontal, 32)
                .foregroundColor(.gray)
            )
            .transition(.move(edge: .trailing))
            .animation(.easeIn)
            .onTapGesture {
                isSearching.toggle()
                print(isSearching)
            }
            
            
            if isSearching {
                Button(action: {
                    isSearching.toggle()
                    searchLocation = ""
                
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancel")
                        .padding(.trailing)
                        .padding(.leading, -16)
                        .foregroundColor(.white)
                })
                .transition(.move(edge: .trailing))
                .animation(.easeIn)
            }
            
        }.padding(3)
    }
}

//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBar(searchLocation: .constant("Doha"), isSearching: .constant(false), function: <#() -> Void#>)
//    }
//}
