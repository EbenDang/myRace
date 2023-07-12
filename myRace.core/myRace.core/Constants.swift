//
//  Constants.swift
//  myRace.core
//
//  Created by Yanbo Dang on 12/7/2023.
//

import Foundation

struct ApiEndPoint {
    static let basePoint: String = "https://api.neds.com.au/rest"
    static let apiVer: String = "/v1"
    static let raceEndPoint: String = "/racing"
}


public enum EnError: Error {
    case invalidResData
    case failed
    case other(error: Error)
}
