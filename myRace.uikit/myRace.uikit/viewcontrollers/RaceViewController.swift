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
        self.showHUD()
        self.viewModel.initViewModel()
    }
    
    // MARK: - Private functions
    private func initTableView() {
        self.tableView.register(RaceItemCell.self, forCellReuseIdentifier: RaceItemCell.getIdentifier())
        self.tableView.separatorStyle = .none
    }
    
    // MARK: - Lazy loading
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        return view.enableAutoLayout(t: view)
    }()
} 
