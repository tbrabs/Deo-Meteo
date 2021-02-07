//
//  WikiImage.swift
//  DeoMeteo
//
//  Created by Tristan on 29/12/2020.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct WikiImage: Decodable {
    let batchcomplete: String
    //    let welcomeContinue: Continue
    let query: Query
}

// MARK: - Query
struct Query: Decodable {
    let pages: Pages
}

// MARK: - Pages
struct Pages: Codable {
    //    let the25552438: The25552438
    let the1, the2, the3, the4: The1
    let the5: The1
//    let the6: The1
//    let the7: The1
//    let the8: The1
//    let the9: The1
    
    enum CodingKeys: String, CodingKey {
        //        case the25552438 = "25552438"
        case the1 = "-1"
        case the2 = "-2"
        case the3 = "-3"
        case the4 = "-4"
        case the5 = "-5"
//        case the6 = "-6"
//        case the7 = "-7"
//        case the8 = "-8"
//        case the9 = "-9"
    }
}

// MARK: - The1
struct The1: Codable {
    let ns: Int
    let title, missing, known: String
    let imageinfo: [Imageinfo]
}

// MARK: - Imageinfo
struct Imageinfo: Codable {
    let url, descriptionurl: String
    let descriptionshorturl: String
}


//// MARK: - The25552438
//struct The25552438: Codable {
//    let pageid, ns: Int
//    let title, imagerepository: String
//    let imageinfo: [Imageinfo]
//}

// MARK: - Continue
//struct Continue: Codable {
//    let gimcontinue, continueContinue: String
//
//    enum CodingKeys: String, CodingKey {
//        case gimcontinue
//        case continueContinue = "continue"
//    }
//}



