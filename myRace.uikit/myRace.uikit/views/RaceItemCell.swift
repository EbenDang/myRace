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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: Self.getIdentifier())
        self.initView()
        self.initLayout()
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
        guard let model = self.model else {
            return
        }
        
        self.meetingName.text = model.meetingName
        self.raceNum.text = "\(model.raceNum)"
        
        let currentTimeInterval = Date.now.timeIntervalSince1970
        let timeInterval = Int(model.advertisedStart.seconds - currentTimeInterval)
        
        let seconds = timeInterval % 60
        let mins = (timeInterval / 60) % 60
        
        if mins == 0 {
            self.adTime.text = "\(seconds)s"
        } else {
            self.adTime.text = "\(mins)m\(seconds)s"
        }
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
