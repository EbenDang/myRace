//
//  BaseViewController.swift
//  myRace.uikit
//
//  Created by Yanbo Dang on 13/7/2023.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {
    
    var hudView: MBProgressHUD?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showHUD() {
        if self.hudView?.isHidden ?? false {
            return
        }
        DispatchQueue.main.async {
            self.hudView = MBProgressHUD.showAdded(to: self.view, animated: true)
            if self.hudView != nil {
                self.view.bringSubviewToFront(self.hudView!)
            }
            self.hudView?.mode = .indeterminate
            self.hudView?.label.text = "Loading..."
            self.hudView?.show(animated: true)
        }
    }
    
    func hideHUD() {
        self.hudView?.hide(animated: true)
        self.hudView = nil
    }
}
