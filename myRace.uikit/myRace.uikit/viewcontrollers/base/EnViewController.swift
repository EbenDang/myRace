//
//  EnViewController.swift
//  myRace.uikit
//
//  Created by Yanbo Dang on 13/7/2023.
//

import UIKit
import Combine
import myRace_core

protocol EnViewController {
    associatedtype ViewModelType
    var viewModel: ViewModelType {get set}
    
    func initView()
    func initLayout()
    func initViewModel()
    func customeNavigationBar()
}

class EnViewControllerImpl<T: ViewModel>: BaseViewController, EnViewController {
    
    typealias ViewModelType = T
    var viewModel: T
    
    var cancellables: Set<AnyCancellable> = []

    init(viewModel: T) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.customeNavigationBar()
        self.initView()
        self.initLayout()
        self.initViewModel()
    }
    
    // MARK: - EnViewController
    func initView() {
    }
    
    func initLayout() {
    }
    
    func initViewModel() {
    }
    
    func customeNavigationBar() {
    }
}
