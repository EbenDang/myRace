//
//  Array+myRace.swift
//  myRace.core
//
//  Created by Yanbo Dang on 13/7/2023.
//

import Foundation

extension Array {
    func validIndex(index: Int) -> Bool {
        return index >= 0 && index < self.count
    }
}
