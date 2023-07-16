//
//  RaceFilterViewController.swift
//  myRace.uikit
//
//  Created by Yanbo Dang on 16/7/2023.
//

import Foundation
import UIKit
import myRace_core

class RaceFilterViewController: EnViewControllerImpl<RaceFilterViewModel> {
    
    override func initView() {
        self.title = "Race Filter"
        self.initTableView()
        self.view.addSubview(self.tableView)
    }
    
    override func initLayout() {
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func initViewModel() {
        self.viewModel.initViewModel()
        
        for filter in self.viewModel.getFilters() {
            let cell = RaceFilterCell()
            cell.model = filter
            self.tableView.addCell(cell: cell)
        }
    }
    
    // MARK: - Private functions
    private func initTableView() {
        self.tableView.staticTableViewDelegate = self
        self.tableView.allowsMultipleSelection = true
    }
    
    // MARK: - Lazy loading
    private lazy var tableView: StaticTableView = {
        let view = StaticTableView()
        return view.enableAutoLayout(t: view)
    }()
}

extension RaceFilterViewController: StaticTableViewDelegate {
    func updateCell(cell: UITableViewCell, rowIndex: Int) {
        return
    }
    
    func didSelectedCell(rowIndex: Int, sectionIndex: Int) {
        guard let model = self.viewModel.selFilter(filterIndex: rowIndex, selected: true),
              self.tableView.allCells.validIndex(index: rowIndex) else {
            return
        }
        
        let cell = self.tableView.allCells[rowIndex] as? RaceFilterCell
        cell?.model = model
    }
    
    func didDeselectCell(rowIndex: Int, sectionIndex: Int) {
        guard let model = self.viewModel.selFilter(filterIndex: rowIndex, selected: false),
              self.tableView.allCells.validIndex(index: rowIndex) else {
            return
        }
        
        let cell = self.tableView.allCells[rowIndex] as? RaceFilterCell
        cell?.model = model
    }
}
