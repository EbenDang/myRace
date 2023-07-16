//
//  StaticTableView.swift
//  myRace.uikit
//
//  Created by Yanbo Dang on 16/7/2023.
//

import Foundation
import UIKit

protocol StaticTableViewDelegate: AnyObject {
    func updateCell(cell: UITableViewCell, rowIndex: Int)
    func didSelectedCell(rowIndex: Int, sectionIndex: Int)
    func didDeselectCell(rowIndex: Int, sectionIndex: Int)
}

class StaticTableView: UITableView {
    
    weak var staticTableViewDelegate: StaticTableViewDelegate?
    
    var allCells: [UITableViewCell] = []
    
    init() {
        super.init(frame: .zero, style: .plain)
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCell(cell: UITableViewCell) {
        self.allCells.append(cell)
    }
    
    func addCells(_ cells: UITableViewCell...) {
        cells.forEach { cell in
            self.addCell(cell: cell)
        }
    }
    
    private func initView() {
        self.separatorStyle = .singleLine
        self.dataSource = self
        self.delegate = self
    }
}


extension StaticTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if self.allCells.validIndex(index: indexPath.row) {
            cell = self.allCells[indexPath.row]
            self.staticTableViewDelegate?.updateCell(cell: cell!, rowIndex: indexPath.row)
        }
        
        return cell ?? UITableViewCell()
    }
}

extension StaticTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.staticTableViewDelegate?.didSelectedCell(rowIndex: indexPath.row, sectionIndex: indexPath.section)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.staticTableViewDelegate?.didDeselectCell(rowIndex: indexPath.row, sectionIndex: indexPath.section)
    }
}
