//
//  RaceViewController.swift
//  myRace.uikit
//
//  Created by Yanbo Dang on 13/7/2023.
//

import Foundation
import UIKit
import myRace_core

class RaceViewController: EnViewControllerImpl<RaceViewModelImpl> {
    
    // MARK: - EnViewController
    override func initView() {
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
        self.viewModel.$isLoading
            .receive(on: RunLoop.main)
            .sink { [weak self ] loading in
                if loading {
                    self?.showHUD()
                } else {
                    self?.hideHUD()
                }
            }.store(in: &self.cancellables)
        
        self.viewModel.$refreshedDate
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }.store(in: &self.cancellables)
        
        self.viewModel.initViewModel()
    }
    
    // MARK: - Private functions
    private func initTableView() {
        self.tableView.register(RaceItemCell.self, forCellReuseIdentifier: RaceItemCell.getIdentifier())
        self.tableView.separatorStyle = .none
        self.tableView.dataSource = self
    }
    
    // MARK: - Lazy loading
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        return view.enableAutoLayout(t: view)
    }()
}


extension RaceViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.getSectionCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getRowCount(sectionIndex: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RaceItemCell.getIdentifier(), for: indexPath) as? RaceItemCell
        
        cell?.model = self.viewModel.getItem(sectionIndex: indexPath.section, rowIndex: indexPath.row)
        
        guard let cell = cell else {
            return UITableViewCell()
        }
        
        return cell
    }
}
