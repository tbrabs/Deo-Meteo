//
//  Favorite.swift
//  DeoMeteo
//
//  Created by Tristan on 06/01/2021.
//

import Foundation

struct Favorite: Codable {
    var favoriteLocation = [String]()
}

//MARK: - Mock Data

let cities =  Favorite(favoriteLocation: ["Doha", "Paris", "Berlin", "Bellohorizonte"])

