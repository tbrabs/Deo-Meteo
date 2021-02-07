//
//  Weather+Ext.swift
//  DeoMeteo
//
//  Created by Tristan on 28/12/2020.
//

import Foundation

extension Current {
    var formattedCurrentDate: String {
        let date = Date(timeIntervalSince1970: dt)
        
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, MMM d"
            return dateFormatter
        }()
        
        return dateFormatter.string(from: date)
    }
    
    var roundedTemp: Int {
        let inTemp = Int(temp)
        return inTemp
    }
}

extension Temp {
    
    var roundedMinTemp: Int {
        let inTemp = Int(min)
        return inTemp
    }
    
    var roundedMaxTemp: Int {
        let inTemp = Int(max)
        return inTemp
    }
}

extension Daily {
    var formattedDailyDate: String {
        let date = Date(timeIntervalSince1970: dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return Calendar.current.isDateInToday(date) ? "Today" : dateFormatter.string(from: date)
    }
}
