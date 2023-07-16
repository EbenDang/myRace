//
//  RaceFilterCell.swift
//  myRace.uikit
//
//  Created by Yanbo Dang on 16/7/2023.
//

import Foundation
import UIKit
import myRace_core

class RaceFilterCell: EnModelTableCell<RaceFilterModel> {
    
    init() {
        super.init(style: .default, reuseIdentifier: Self.getIdentifier())
    }
    
    static func getIdentifier() -> String {
        return "com.entain.app.race.cell.raceFilter"
    }
    
    override func didUpdateModel() {
        guard let model = self.model else {
            return
        }
        
        self.textLabel?.text = model.filterName
        self.accessoryType = model.selected ? .checkmark : .none
    }
}
