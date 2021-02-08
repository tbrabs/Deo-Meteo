//
//  LocationWeather+Ext.swift
//  DeoMeteo
//
//  Created by Tristan on 03/02/2021.
//

import Foundation

extension Main {
    
    var roundedTemp: Int {
        let inTemp = Int(temp)
        return inTemp
    }
    
    var roundedMinTemp: Int {
        let inTemp = Int(temp_min)
        return inTemp
    }
    
    var roundedMaxTemp: Int {
        let inTemp = Int(temp_max)
        return inTemp
    }
}
