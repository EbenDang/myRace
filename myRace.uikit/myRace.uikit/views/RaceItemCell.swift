//
//  RaceItemCell.swift
//  myRace.uikit
//
//  Created by Yanbo Dang on 13/7/2023.
//

import Foundation
import UIKit
import myRace_core

class RaceItemCell: EnModelTableCell<RaceSummaryItem> {
    
    init() {
        super.init(style: .default, reuseIdentifier: Self.getIdentifier())
    }
    
    static func getIdentifier() -> String {
        return "com.entain.app.race.cell.raceItem"
    }
    
    override func initView() {
        super.initView()
        self.contentView.addSubviews(self.meetingName, self.raceNum, self.adTime)
    }
    
    override func initLayout() {
        NSLayoutConstraint.activate([
            self.meetingName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.meetingName.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            
            self.raceNum.leadingAnchor.constraint(equalTo: self.meetingName.trailingAnchor, constant: 10),
            
            self.raceNum.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            
            self.adTime.leadingAnchor.constraint(equalTo: self.raceNum.trailingAnchor, constant: 10),
            self.adTime.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.adTime.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.adTime.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    override func didUpdateModel() {
        self.meetingName.text = self.model?.meetingName ?? String.NA
//        self.raceNum.text = self.model?.raceNum ?? String.NA
//        self.adTime.text = "adc"
    }
        
    //MARK: - Lazy loading
    private lazy var meetingName: UILabel = {
        let view = UILabel()
        return view.enableAutoLayout(t: view)
    }()
    
    private lazy var raceNum: UILabel = {
        let view = UILabel()
        return view.enableAutoLayout(t: view)
    }()
    
    private lazy var adTime: UILabel = {
        let view = UILabel()
        return view.enableAutoLayout(t: view)
    }()
}
