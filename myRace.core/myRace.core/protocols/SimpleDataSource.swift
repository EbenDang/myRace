//
//  SimpleDataSource.swift
//  myRace.core
//
//  Created by Yanbo Dang on 13/7/2023.
//

import Foundation

public protocol SimpleDataSource {
    associatedtype ItemType
    
    func getSectionCount() -> Int
    func getRowCount(sectionIndex: Int) -> Int
    func getItem(sectionIndex: Int, rowIndex: Int) -> ItemType?
}
