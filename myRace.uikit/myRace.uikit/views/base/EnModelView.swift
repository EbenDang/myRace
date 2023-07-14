//
//  EnView.swift
//  myRace.uikit
//
//  Created by Yanbo Dang on 13/7/2023.
//

import Foundation
import UIKit
import myRace_core

protocol ModelView {
    associatedtype ModelType
    var model: ModelType? { get set }
    func didUpdateModel()
}

class EnModelViewImpl<T: Model>: BaseView, ModelView {

    typealias ModelType = T
    var model: T? {
        didSet {
            self.didUpdateModel()
        }
    }
    
    func didUpdateModel() {
    }
}

class BaseTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        self.selectionStyle = .none
    }
    
    func initLayout() {
    }
}

class EnModelTableCell<T>: BaseTableViewCell, ModelView {
    
    typealias ModelType = T
    var model: T? {
        didSet {
            self.didUpdateModel()
        }
    }
    
    func didUpdateModel() {
    }
}
