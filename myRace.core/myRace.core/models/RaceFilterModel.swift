//
//  RaceFilterModel.swift
//  myRace.core
//
//  Created by Yanbo Dang on 16/7/2023.
//

import Foundation

public struct RaceFilterModel: Identifiable, Equatable {
    public let id:String
    public let filterName: String
    public var selected: Bool = false
    
    public init(id: String, filteName: String, selected: Bool) {
        self.id = id
        self.filterName = filteName
        self.selected = selected
    }
    
    public mutating func selFilter(_ selected: Bool) {
        self.selected = selected
    }
    
    public static func ==(lhs: RaceFilterModel, rhs: RaceFilterModel) -> Bool {
        return lhs.id == rhs.id && lhs.filterName == rhs.filterName && lhs.selected == rhs.selected
    }
}
