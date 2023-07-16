//
//  RaceFilterModel.swift
//  myRace.core
//
//  Created by Yanbo Dang on 16/7/2023.
//

import Foundation

public struct RaceFilterModel {
    public let filterId:String
    public let filteName: String
    public var selected: Bool = false
    
    public mutating func selFilter(_ selected: Bool) {
        self.selected = selected
    }
}
