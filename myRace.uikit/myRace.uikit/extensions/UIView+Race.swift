//
//  UIView+Race.swift
//  myRace.uikit
//
//  Created by Yanbo Dang on 13/7/2023.
//

import Foundation

import UIKit

extension UIView {
    func enableAutoLayout<T: UIView>(t: T) -> T {
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
