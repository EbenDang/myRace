//
//  BaseView.swift
//  myRace.uikit
//
//  Created by Yanbo Dang on 13/7/2023.
//

import UIKit
import UIKit

class BaseView: UIView {
    
    init() {
        super.init(frame: .zero)
    }

    func initView() {
        
    }
    
    func initLayout() {
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
