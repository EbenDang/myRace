//
//  RaceFilterModel.swift
//  myRace.core
//
//  Created by Yanbo Dang on 16/7/2023.
//

import Foundation

public struct RaceFilterModel: Identifiable {
    public let id:String
    public let filteName: String
    public var selected: Bool = false
    
    public init(id: String, filteName: String, selected: Bool) {
        self.id = id
        self.filteName = filteName
        self.selected = selected
    }
    
    public mutating func selFilter(_ selected: Bool) {
        self.selected = selected
    }
}
