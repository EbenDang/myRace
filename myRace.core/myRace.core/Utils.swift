//
//  Utils.swift
//  myRace.core
//
//  Created by Yanbo Dang on 14/7/2023.
//

import Foundation

class Utils {
    static func formatFromTimeInterval(timeInterval: Double, dateFormat: String) -> String {
        let date = Date(timeIntervalSince1970: timeInterval)
        let formater = DateFormatter()
        formater.dateFormat = dateFormat
        return formater.string(from: date)
    }
}
